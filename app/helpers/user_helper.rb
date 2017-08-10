module UserHelper
  def current_user? user
    user == current_user
  end
  def gender_photo_path(user)
    user.gender == 'male' ? 'elements/Avatar bleu-01.png' : 'elements/Avatar rose-01.png'
  end

  def default_image_tag(user)
    if user.photo?
      cl_image_tag user.photo.path, class: "avatar-profile", crop: :fill
    else
      image_tag gender_photo_path(user), alt: 'avatar', class: "avatar-profile"
    end
  end

  def link_to_edit(user, image_tag)
    if current_user == user
      link_to image_tag, edit_user_registration_path
    else
      image_tag
    end
  end

  def date_photo_path(user)
    'elements/birth-dates/'+user.birthday.strftime("%m")+"/"+user.birthday.strftime("%d%m")+'.png'
  end

  def gender_type(user)
    user.gender == 'male' ? 'color-men' : 'color-women'
  end
end
