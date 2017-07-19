class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end
  def edit
      @user = current_user
      @hash = Gmaps4rails.build_markers([@user]) do |user, marker|
        marker.lat user.latitude
        marker.lng user.longitude
        marker.picture({
            "url": "#{view_context.image_path(@gender_icon = (user.gender == 'male' ? 'elements/Point-bleu-01.png' : 'elements/Point-rose-01.png'))}",
            "width":  24,
            "height": 45
          })
      end
  end
  def update
    super
  end
end
