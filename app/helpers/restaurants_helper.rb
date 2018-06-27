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
    Date::DAYNAMES.each_with_index.map { |name, index| [name, index] }
  end

  def default_weekday_option
    Date.today.wday
  end

  def render_restaurant(restaurant)
    restaurant.to_json(only: :name)
  end
end
