class PickupRequestsController < ApplicationController
  before_action :set_pickup_request, only: [:show, :edit, :update, :destroy]


      def index
        @pickup_requests = PickupRequest.all
        # @profile = Profile.find(params[:id])
      end
  
      def new
        @pickup_request = PickupRequest.new
      end

      def show
      end
    
      def create
        # binding.pry
        @pickup_request = PickupRequest.create(pickup_request_params)
        @pickup_request.user = current_user
        @pickup_request.delivery_address = current_user.profile.partial_address
        @pickup_request.save!
        redirect_to pickup_requests_path
        # item = Item.new
      end
  
      def edit
      end
  
      def update
        permitted_columns = pickup_request_params
        @pickup_request.update_attributes(permitted_columns)
        redirect_to pickup_request_path
      end
  
      def destroy
        @pickup_request.destroy
      
        redirect_to pickup_requests_path, notice: "Delete success"    
      end
      private

    def set_pickup_request
      @pickup_request = PickupRequest.find(params[:id])
    end

    def pickup_request_params
      params.require(:pickup_request).permit([
        :description, 
        :pickup_address,
        :delivery_address,
        :payment_amount,
        :image,
        :item_name
      ])
    end
end