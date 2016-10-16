class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
    omniauth_providers: Identity::PROVIDERS

  validates :full_name, presence: true

  has_many :identities, dependent: :destroy
end
