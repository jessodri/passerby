class PickupRequestsController < ApplicationController
    def index
        @pickup_requests = PickupRequest.all
      end
  
      def new
        @pickup_request = PickupRequest.new
      end

      def show
        @pickup_request = PickupRequest.find(params[:id])
      end
    
      def create
        @pickup_request = PickupRequest.create(params.require(:profile).permit(:first_name, :last_name, :bio, :image_data, :address_line_one, :address_line_two, :city, :state, :postcode, :country_code))
        @pickup_request.user = current_user
        @pickup_request.save!
        redirect_to pickup_requests_path
        # item = Item.new
      end
  
      def edit
        @pickup_request = PickupRequest.find(params[:id])
      end
  
      def update
        @pickup_request = PickupRequest.find(params[:id])
        permitted_columns = params.require(:profile).permit(:first_name, :last_name, :bio, :image_data, :address_line_one, :address_line_two, :city, :state, :postcode, :country_code)
        @pickup_request.update_attributes(permitted_columns)
        redirect_to pickup_request_path
      end
  
      def destroy
        @pickup_request = PickupRequest.find(params[:id])
        @pickup_request.destroy
      
        redirect_to profile_path, notice: "Delete success"    
      end
  
end