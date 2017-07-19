class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :define_channels_users

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    sign_up_attributes = [:first_name, :last_name, :email, :city, :country, :gender, :bio, :music, :book, :movie, :birthday, :photo]
    update_attributes = [:bio, :music, :book, :movie, :photo]
    devise_parameter_sanitizer.permit(:sign_up, keys: sign_up_attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: update_attributes)
  end

  def define_channels_users
    gon.tab = current_user.channels.map(&:id) if current_user
  end

end
