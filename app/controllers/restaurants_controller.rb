class RestaurantsController < ApplicationController
  def index
    @weekday = params[:weekday] || helpers.default_weekday_option
    @time = params[:time] || helpers.default_time_option

    @restaurants = Restaurant.open_at(@weekday, @time)
  end
end
