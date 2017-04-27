class Connection < ActiveRecord::Base
  has_many :interactions
  belongs_to :list

  def full_name
    first_name + " " + last_name
  end
end
