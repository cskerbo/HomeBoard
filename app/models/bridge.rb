class Bridge < ApplicationRecord
  belongs_to :home
  has_many :bulbs
  has_many :groups
  validates_presence_of :identifier, :internalip
end