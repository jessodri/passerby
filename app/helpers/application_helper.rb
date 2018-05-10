module ApplicationHelper

    def google_map_image_tag(profile)
        image_tag "http://maps.googleapis.com/maps/api/staticmap?center=#{@profile.latitude},#{@profile.longitude}&zoom=14&size=300x300&sensor=false"
    end

    def google_map_image(pickup)
        image_tag "http://maps.googleapis.com/maps/api/staticmap?center=#{@pickup_request.latitude},#{@pickup_request.longitude}&zoom=14&size=200x200&sensor=false"
    end
    
end
