class RestaurantsController < ApplicationController
  def index
    @weekday = params[:weekday] || helpers.default_weekday_option
    @time = params[:time] || helpers.default_time_option

    @restaurants = Restaurant
                   .joins(:open_hours)
                   .where(':time >= open_hours.open_at and :time < open_hours.close_at', time: @time)
                   .where(open_hours: { weekday: @weekday })
  end
end
