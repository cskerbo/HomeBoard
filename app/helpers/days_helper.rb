module DaysHelper

  def find_current_day(weather_widget_id)
    current_date = Time.now.strftime('%-m/%-d')
    day = Day.where('date = ? AND weather_widget_id = ?', current_date, weather_widget_id).first
    day.update(today: true)
    day
  end

  def find_current_forecast(weather_widget_id)
    days_array = []
    current_date = Time.now.strftime('%-m/%-d')
    integer_current_date = Date.today.to_time.to_i
    days = Day.where('date != ? AND weather_widget_id = ?', current_date, weather_widget_id).sort_by &:id
    days.each do |day|
      integer_date = day.date.to_time.to_i
      if integer_date > integer_current_date
        days_array << day
      end
    end
    days_array.select.take(5) { |day| day.date.to_time.to_i > integer_current_date}
  end

end