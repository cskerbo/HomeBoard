class Group < ApplicationRecord
  belongs_to :bridge
  has_many :bulbs
end