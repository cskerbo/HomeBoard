class Bridge < ApplicationRecord
  belongs_to :home
  has_many :bulbs
  has_many :groups
  has_many :scenes, through: :groups
  validates_presence_of :identifier, :internalip
end