class UsersController < ApplicationController

  def index
    @birthday = session[:birthday] ? DateTime.parse(session[:birthday]) : current_user.birthday
    @length = session[:length] ? session[:length] : 10000
    @users = current_user.selected_users(@birthday, session[:male].to_i, session[:female].to_i, @length)
    google_hash(@users)
  end

  def show
    @user = User.find(params[:id])
    # @user_coordinates = { lat: @user.latitude, lng: @user.longitude }
    google_hash([@user])
  end
end
