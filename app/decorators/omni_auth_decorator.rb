class OmniAuthDecorator < ApplicationDecorator
  delegate :provider

  def provider_name
    I18n.t("active_record.attributes.identity.provider_name.#{provider}")
  end
end
