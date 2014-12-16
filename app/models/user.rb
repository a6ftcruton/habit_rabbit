class User < ActiveRecord::Base
  has_many :habits

  validates :provider,
  :uid,
  :name,
  :image,
  :oauth_token,
  :oauth_secret, presence: true

  def self.from_omniauth(auth)
    where(uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.image = auth.info.image
      user.oauth_token = auth.credentials.token
      user.oauth_secret = auth.credentials.secret
      user.save!
    end
  end
end
