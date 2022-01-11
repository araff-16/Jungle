class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :password, confirmation: { case_sensitive: true }, length: {minimum: 5}
  validates :password_confirmation, presence: true
  
  validates :email, presence: true, uniqueness: { case_sensitive: false } 

  # we put a self here because we want it to refer tothe class itself 
  # not the instance of a user 
  def self.authenticate_with_credentials(email, password)
    user = self.find_by_email(email.strip.downcase)
    if user && user.authenticate(password)
      user
    end
  end



end
