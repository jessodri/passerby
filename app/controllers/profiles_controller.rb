class ProfilesController < ApplicationController
    def index
        @profiles = Profile.all
      end
  
      def new
        @profile = Profile.new
      end

      def show
        @profile = Profile.find(params[:id])
      end
    
      def create
        @profile = Profile.create(params.require(:profile).permit(:first_name, :last_name, :bio, :image_data, :address_line_one, :address_line_two, :city, :state, :postcode, :country_code))
        @profile.user = current_user
        @profile.save!
        redirect_to profiles_path
        # item = Item.new
      end
  
      def edit
        @profile = Profile.find(params[:id])
      end
  
      def update
        @profile = Profile.find(params[:id])
        permitted_columns = params.require(:profile).permit(:first_name, :last_name, :bio, :image_data, :address_line_one, :address_line_two, :city, :state, :postcode, :country_code)
        @profile.update_attributes(permitted_columns)
        redirect_to show_path
      end
  
      def destroy
        @profile = Profile.find(params[:id])
        @profile.destroy
      
        redirect_to profile_path, notice: "Delete success"    
      end
  
end
  