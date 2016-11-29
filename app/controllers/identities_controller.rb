class IdentitiesController < ApplicationController
  before_action :authenticate_user!

  expose(:identity, scope: -> { current_user.identities })

  def destroy
    action = identity.destroy ? :notice : :alert
    flash[action] = t "flash.actions.destroy.#{action}", resource_name: Identity.model_name.human
    redirect_to edit_user_registration_url
  end
end
