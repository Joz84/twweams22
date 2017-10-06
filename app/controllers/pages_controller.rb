class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :birthday]

  def home
  end

  def birthday
    session[:birthday] = User.birthdate(datetime_params)
    redirect_to new_user_registration_path
  end

  def selection
    session[:birthday] = User.birthdate(selection_params)
    session[:length] = params[:length].to_i
    session[:male] = selection_params[:male]
    session[:female] = selection_params[:female]
    redirect_to root_path
  end

  private

  def datetime_params
    params.require(:birthday).permit(:birthdate)
  end

  def selection_params
    params.require(:selection).permit(:birthdate, :male, :female)
  end
end
