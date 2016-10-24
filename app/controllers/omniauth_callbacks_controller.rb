class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include OmniauthHelper

  Identity::PROVIDERS.each do |provider|
    define_method(provider) do
      show_verification_notice && return unless auth_verified?

      current_user ? connect_identity : process_sign_in
    end
  end

  private

  def show_verification_notice
    redirect_to root_path, flash: { error: t("omniauth.verification.failure", kind: provider_name(auth.provider)) }
  end

  def auth_verified?
    AuthVerificationPolicy.new(auth).verified?
  end

  def auth
    request.env["omniauth.auth"]
  end

  def connect_identity
    ConnectIdentity.call(user: current_user, auth: auth)
    redirect_to edit_user_registration_path
  end

  def process_sign_in
    user = FetchOauthUser.call(auth: auth).user
    sign_in_and_redirect user, event: :authentication
  end
end
