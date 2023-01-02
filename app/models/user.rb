class User < ActiveRecord::Base

  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    email = email.strip.downcase
    user = User.where("email = '#{email}'")

    if (user && (BCrypt::Password.new(user[0][:password_digest])) == password)
      return user
    else
      return nil
    end
  end
end