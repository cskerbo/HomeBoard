class Bridge < ApplicationRecord
  belongs_to :hue_widget
  has_many :bulbs


end