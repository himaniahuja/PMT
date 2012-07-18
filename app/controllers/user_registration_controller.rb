# This controller is customized over devise
class UserRegistrationController < Devise::RegistrationsController
  prepend_before_filter :require_no_authentication, :only => []
  prepend_before_filter :authenticate_scope!, :only => [:edit, :update, :destroy, :new, :create]

  load_and_authorize_resource :class => "User"

  # Overrides the create method in RegistrationsController
  #
  # The new user will not be signed in after it is created.
  #
  # POST /resource
  def create
    build_resource

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :inactive_signed_up, :reason => inactive_reason(resource) if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render_with_scope :new }
    end
  end

end
