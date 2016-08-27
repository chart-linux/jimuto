class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user! # redirect to home#index if not loggined.
  before_filter :configure_permitted_parameters, if: :devise_controller? # add 'name' column to users and enable for update and register

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :current_password) }
    end
    
    def admin_user!
      unless current_user&.admin?
        return render status: :forbidden, text: 'You are not administrator.'
      end
    end
end
