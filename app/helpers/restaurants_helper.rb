module RestaurantsHelper
  def time_options
    options = []
    (0..23).to_a.each do |hour|
      hour = format('%02d', hour)
      options << "#{hour}:00"
      options << "#{hour}:30"
    end
    options
  end

  def default_time_option
    '10:00'
  end

  def weekday_options
    Date::ABBR_DAYNAMES.map { |name| [name, name.downcase] }
  end

  def default_weekday_option
    today = Date.today
    Date::ABBR_DAYNAMES[today.wday].downcase
  end

  def render_restaurant(restaurant)
    restaurant.to_json(only: :name)
  end
end
