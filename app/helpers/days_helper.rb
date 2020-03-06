module DaysHelper

  def find_current_day(weather_widget_id)
    current_date = Time.now.strftime('%-m/%-d')
    day = Day.where('date = ? AND weather_widget_id = ?', current_date, weather_widget_id).first
    day
  end

  def find_current_forecast(weather_widget_id)
    current_date = Time.now.strftime('%-m/%-d')
    days = Day.where('date != ? AND weather_widget_id = ?', current_date, weather_widget_id).sort_by &:id
    days.take(5)
  end

end