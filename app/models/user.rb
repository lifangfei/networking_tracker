class User < ActiveRecord::Base
  has_many :lists
  has_many :connections, through: :lists
  has_many :interactions, through: :connections

  def full_name
    "#{first_name} #{last_name}"
  end
end
