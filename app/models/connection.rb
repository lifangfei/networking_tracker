class Connection < ActiveRecord::Base
  has_many :interactions
  belongs_to :list
end
