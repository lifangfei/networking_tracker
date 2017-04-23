class User < ActiveRecord::Base
  has_many :lists
  has_many :connections, through: :lists
  has_many :interactions, through: :connections

  include BCrypt

  def full_name
    "#{first_name} #{last_name}"
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end


  def self.authenticate(username, password)
    @user = User.find_by(username: username)
    if @user && @user.password == password
      @user
    else
      false
    end
  end
end
