class User < ApplicationRecord  
  include DeviseTokenAuth::Concerns::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :projects

  scope :for_facebook, -> (auth) { where(provider: 'facebook', uid: auth[:uid]) }

  def self.from_omniauth(auth)
    for_facebook(auth).first_or_create do |user|
      user.email = auth[:email]
      user.password = Devise.friendly_token[0,20]
      user.uid = auth[:uid]
      user.provider = 'facebook'
    end
  end

  validates_presence_of :email
end
