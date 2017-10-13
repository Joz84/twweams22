class UsersController < ApplicationController

  def index
    @birthday = session[:birthday] ? DateTime.parse(session[:birthday]) : current_user.birthday
    @length = session[:length] ? session[:length] : 10000
    @users = current_user.selected_users(@birthday, session[:male].to_i, session[:female].to_i, @length)
    # @users = User.all
    google_hash(@users)
  end

  def show
    @user = User.find(params[:id])
    # @user_coordinates = { lat: @user.latitude, lng: @user.longitude }
    google_hash([@user])
    end
  end

  private

  def google_hash(users)
    @hash = Gmaps4rails.build_markers(users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.picture({
          "url": view_context.image_path("elements/Point-#{user.male? ? 'bleu' : 'rose'}-01.png"),
          "width":  24,
          "height": 45
        })
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
  end
end
