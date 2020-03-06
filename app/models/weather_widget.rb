class WeatherWidget < ApplicationRecord
  belongs_to :home
  has_many :days
end