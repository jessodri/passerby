class PickupRequestsController < ApplicationController
  before_action :set_pickup_request, only: [:show, :accept, :edit, :update, :destroy]
  before_action :auth_actions, only: [:update, :edit, :destroy]
  
      def index
        @pickup_requests = PickupRequest.all
        # @profile = Profile.find(params[:id])
      end
  
      def new
        @pickup_request = PickupRequest.new
      end

      def show

      end

      def accept
        @pickup_request = PickupRequest.find(params[:id])
        if current_user.id != @pickup_request.user_id
          # flash[:notice] = "You cannot accept your own request!"
          user_to_pickup = UserToPickup.new(user_id: current_user.id, pickup_request_id: @pickup_request.id, accepted: true)
          
          user_to_pickup.save!  
          redirect_to pickup_requests_path, notice: "You have successfully accepted this request!"
        
        elsif user_to_pickup.accepted == true
          respond_to do |format|
          format.html { redirect_to pickup_request_path(@pickup_request), notice: 'This request is no longer available.' }
          format.json { head :no_content }
          end
        
        else
          respond_to do |format|
          format.html { redirect_to pickup_request_path(@pickup_request), notice: 'You cannot accept your own request!' }
          format.json { head :no_content }
          end
          
        end
      end
      
      def create
        # binding.pry
        @pickup_request = PickupRequest.create(pickup_request_params)
        @pickup_request.user = current_user
        @pickup_request.delivery_address = current_user.profile.partial_address
        @pickup_request.save!
        
        redirect_to pickup_requests_path
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

      def auth_actions
        authorize @pickup_request
      end

      def pickup_request_params
        params.require(:pickup_request).permit([
          :description, 
          :pickup_address,
          :delivery_address,
          :payment_amount,
          :image,
          :item_name,
          :user_id
        ])
      end
end