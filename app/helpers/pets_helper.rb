module PetsHelper


  def update_status1(pet, home)
    time = local_time(home.timezone)
    pet.update(status1_time: time)
  end

  def update_status2(pet, home)
    time = local_time(home.timezone)
    pet.update(status2_time: time)
  end

  private

  def local_time(home_timezone)
    timezone = Timezone[home_timezone]
    unformatted_time = timezone.utc_to_local(Time.now)
    time = unformatted_time.strftime("%-I:%M %P")
    time
  end

  def current_day(home_timezone)
    timezone = Timezone[home_timezone]
    unformatted_time = timezone.utc_to_local(Time.now)
    date = unformatted_time.strftime("%A")
    date
  end

end
