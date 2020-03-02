class Group < ApplicationRecord
  belongs_to :bridge
  has_many :bulbs
  has_many :scenes
end