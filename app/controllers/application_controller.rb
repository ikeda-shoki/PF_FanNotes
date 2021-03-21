class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :currrent_notifications

  def after_sign_in_path_for(resource)
    main_path
  end
  
  def currrent_notifications
    if user_signed_in?
      @notifications = current_user.passive_notifications.all
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:account_name, :is_reception])
  end

end
