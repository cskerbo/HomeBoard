class Day < ApplicationRecord
  belongs_to :weather_widget
  validates :date, uniqueness: {scope: :weather_widget_id}
end