class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :auth_actions, only: [:update, :edit, :destroy]

  def index
    @profiles = Profile.all
  end

  def new
    @profile = Profile.new
  end

  def show
    @pickup_requests = @profile.user.pickup_requests
    # @user_to_pickup = UserToPickup.find(params[:id]) #something
  end

  def create
    @profile = Profile.create(profile_params)
    @profile.user = current_user
    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @profile.update_attributes(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_path, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

    private

    def set_profile
      @profile = Profile.find(params[:id])
    end

    def auth_actions
      authorize @profile
    end

    def profile_params
      params.require(:profile).permit([
        :first_name, 
        :last_name, 
        :bio, 
        :remove_image,
        :image, 
        :address_line_one, 
        :address_line_two, 
        :city, 
        :state, 
        :postcode, 
        :country_code
      ])
    end
  
end
  