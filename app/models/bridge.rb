class Bridge < ApplicationRecord
  belongs_to :home
  has_many :bulbs
  validates_presence_of :identifier, :internalip

end