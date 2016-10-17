class PasswordsController < ApplicationController
  skip_before_action :check_user_password

  def edit
  end

  def update
    if current_user.update(user_params)
      sign_in :user, current_user, bypass: true
      redirect_to root_path, notice: t("passwords.updated")
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation).merge(password_change_needed: false)
  end
end
