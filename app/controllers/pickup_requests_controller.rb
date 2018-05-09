class PickupRequestsController < ApplicationController
  before_action :set_pickup_request, only: [:show, :accept, :edit, :update, :destroy, :charge]
  before_action :auth_actions, only: [:update, :edit, :destroy]
  before_action :authenticate_user!, only: [:charge]

      def index
        @pickup_requests = PickupRequest.all
        unless params[:pickup_requests].present?
          @pickup_requests = PickupRequest.all
          else
          pickup_address = params[:pickup_requests][:search]
          # @products = Product.where(name: product_name)
          @pickup_requests = PickupRequest.search_by_pickup_address(pickup_address)
          end
      end
  
      def new
        @pickup_request = PickupRequest.new
      end

      def show

      end

      def charge

        if current_user.stripe_id.blank?
        customer = Stripe::Customer.create(
          email: params[:stripeEmail],
          source: params[:stripeToken]
        )
        current_user.stripe_id = customer.id
        current_user.save! #bad code above
        end 
  
         charge = Stripe::Charge.create(
          customer: current_user.stripe_id,
          amount: @pickup_request.payment_amount.to_i,
          description: @pickup_request.description,
          currency: 'AUD'
        )
        
        # current_user.charges << Charge.new(charge_id: charge.id)
  
        flash[:notice] = 'Payment Made!'
        redirect_back fallback_location: pickup_request_path
  
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_back fallback_location: pickup_request_path
    
    end

      def accept
        @pickup_request = PickupRequest.find(params[:id])
        if current_user.id != @pickup_request.user_id
          # flash[:notice] = "You cannot accept your own request!"
          user_to_pickup = UserToPickup.new(user_id: current_user.id, pickup_request_id: @pickup_request.id, accepted: true)
          user_to_pickup.save!  
          AcceptRequestMailer.accept_request(current_user).deliver_now

          redirect_to pickup_request_path, notice: "You have successfully accepted this request!"
        
        else
          respond_to do |format|
          format.html { redirect_to pickup_request_path(@pickup_request), notice: 'You cannot accept your own request!' }
          format.json { head :no_content }
          end
          
        end
      end

      def unaccept
        # user_to_pickup = UserToPickup.find(params[:id])
        pickup_request = PickupRequest.find(params[:id])
        # pickup_request.user_to_pickup.destroy!
        # user = User.find(params[:id])
        UserToPickup.where(pickup_request_id: pickup_request.id).destroy_all
        redirect_to pickup_request_path, notice: "You have successfully reset this request!"

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
          :user_id,
          user_to_pickups: [:accepted],
        ])
      end
end