class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :rating
  has_many :favorites

  validates :email, format: URI::MailTo::EMAIL_REGEXP
  enum role: %i[user admin]
  # enum role: {
  #   user: 0,       # User role with a value of 0
  #   admin: 1,     # Admin role with a value of 1
  #   moderator: 2  # Moderator role with a value of 2
  # }

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end 
end

