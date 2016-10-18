class Identity < ActiveRecord::Base
  PROVIDERS = OmniAuth.strategies.map { |s| s.to_s.demodulize.underscore }.drop(1)

  belongs_to :user

  validates :user, :provider, :uid, presence: true
  validates :uid, uniqueness: { scope: :provider }

  def self.from_omniauth(auth)
    find_by(provider: auth.provider, uid: auth.uid)
  end
end