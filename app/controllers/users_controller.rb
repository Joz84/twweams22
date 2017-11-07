class UsersController < ApplicationController
  def picture
    current_user.photo = picture_params[:photo]
    current_user.save
    redirect_to edit_user_registration_path
  end

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

  private

  def picture_params
    params.require(:user).permit(:photo)
  end

end
