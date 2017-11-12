class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :define_user_birthday

  def google_hash(users)
    @hash = Gmaps4rails.build_markers(users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.picture({
        "url": view_context.image_path("elements/Point-#{user.male? ? 'bleu' : 'rose'}-01.png"),
        "width":  24,
        "height": 45
      })
      marker.infowindow render_to_string(partial: "/users/map_box", locals: { user: user })
    end
  end

  protected

  def configure_permitted_parameters
    sign_up_attributes = [:first_name, :last_name, :email, :city, :country, :gender, :bio, :music, :book, :movie, :birthday, :photo]
    update_attributes = [:bio, :music, :book, :movie, :photo]
    devise_parameter_sanitizer.permit(:sign_up, keys: sign_up_attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: update_attributes)
  end

  def define_user_birthday
    gon.user = current_user.birthday if current_user
  end


end
