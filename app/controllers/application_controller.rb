class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:home]

  def after_sign_in_path_for(user)
    #return path e.g. '/profile/edit' 
    profile_edit_path if user.profile.nil?
  end

end
