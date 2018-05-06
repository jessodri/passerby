require "image_processing/mini_magick"

class ImageUploader < Shrine
    include ImageProcessing::MiniMagick
  
    plugin :determine_mime_type
    plugin :logging, logger: Rails.logger
    plugin :remove_attachment
    plugin :store_dimensions
    plugin :validation_helpers
    plugin :versions, names: [:original, :thumb, :medium]
    plugin :processing
    plugin :delete_raw # delete processed files after uploading
  
    Attacher.validate do
      validate_max_size 2.megabytes, message: 'is too large (max is 2 MB)'
      validate_mime_type_inclusion ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
    end
  
    process(:store) do |io, context|
      original = io.download
      pipeline = ImageProcessing::MiniMagick.source(original)
  
      size_80 = pipeline.resize_to_limit!(80, 80)
      size_300 = pipeline.resize_to_limit!(300, 300)
  
      original.close!
  
      { original: io, thumb: size_80, medium: size_300 }
    end
  end



