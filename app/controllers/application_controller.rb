class ApplicationController < ActionController::Base
  include Authentication
  include Authorization

  protect_from_forgery with: :exception

  responders :flash
  respond_to :html

  before_action :check_user_password, if: :current_user

  private

  def check_user_password
    redirect_to edit_passwords_path, alert: "Set your password, please" if current_user.password_change_needed
  end
end
