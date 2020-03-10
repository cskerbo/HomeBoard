class Day < ApplicationRecord
  belongs_to :weather_widget
  validates_uniqueness_of :date
end