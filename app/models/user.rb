class User < ActiveRecord::Base
  has_secure_password(validations: false)
  has_many :habits
  validates :name, presence: true

  with_options(:unless => :is_twitter?) do |non_twitter_user|
    non_twitter_user.validates :email_address, presence: true
    non_twitter_user.validates :password, presence: true, confirmation: true
  end

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

  def is_twitter?
    [uid, provider, oauth_token, oauth_secret].all?(&:present?)
  end
end
