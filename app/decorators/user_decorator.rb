class UserDecorator < ApplicationDecorator
  delegate :id, :first_name, :last_name, :email, :identities, :errors

  def full_name_with_email
    "#{full_name} (#{object.email})"
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
