class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end
  def edit
    google_hash([resource])
  end

  def update
    super
  end
end
