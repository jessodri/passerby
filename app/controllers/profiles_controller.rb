class ProfilesController < ApplicationController
  before_action :profile, only: [:show, :edit, :update, :destroy]

  def index
    @profiles = Profile.all
  end

  def new
    @profile = Profile.new
  end

  def show
  end

  def create
    @profile = Profile.create(profile_params)
    @profile.user = current_user
    @profile.save!
    redirect_to profiles_path
  end

  def edit
  end

  def update
    @profile.update_attributes(profile_params)
    redirect_to show_path
  end

  def destroy
    @profile.destroy
    redirect_to profile_path, notice: "Delete success"    
  end

    private

    def set_profile
      @profile = Profile.find(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :bio, :image_data, :address_line_one, :address_line_two, :city, :state, :postcode, :country_code)
    end
  
end
  