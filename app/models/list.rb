class List < ActiveRecord::Base
  belongs_to :user
  has_many :connections
  has_many :interactions, through: :connections
end
