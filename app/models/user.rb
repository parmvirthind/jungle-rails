class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: {case_sensitive: false}

  validates :password, length: {minimum: 3}

  def self.authenticate_with_credentials(email, password)
    email = email.downcase.strip
    @user = User.find_by(email: email)
    if @user.authenticate(password)
      @user
    else 
      nil
    end
  end

end
