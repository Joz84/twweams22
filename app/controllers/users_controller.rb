class UsersController < ApplicationController

  def index
    @birthday = session[:birthday] ? DateTime.parse(session[:birthday]) : current_user.birthday
    @length = session[:length] ? session[:length] : 10000
    @users = current_user.selected_users(@birthday, session[:male].to_i, session[:female].to_i, @length)
    # @users = User.all

    @hash = Gmaps4rails.build_markers(@users) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.picture({
          "url": "#{view_context.image_path(@gender_icon = (user.gender == 'male' ? 'elements/Point-bleu-01.png' : 'elements/Point-rose-01.png'))}",
          "width":  24,
          "height": 45
        })
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
  end

  def show
    @user = User.find(params[:id])
    @user_coordinates = { lat: @user.latitude, lng: @user.longitude }

    @hash = Gmaps4rails.build_markers([@user]) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.picture({
          "url": "#{view_context.image_path(@gender_icon = (user.gender == 'male' ? 'elements/Point-bleu-01.png' : 'elements/Point-rose-01.png'))}",
          "width":  24,
          "height": 45
        })
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    end
  end
end
