require 'rails_helper'

RSpec.describe RestaurantsController, type: :request do
  let!(:restaurant) { create(:restaurant, name: 'MacDownload') }
  let!(:open_hour) { create(:open_hour, restaurant: restaurant, weekday: 1, open_at: '08:00', close_at: '17:00') }

  context 'GET /restaurants' do
    it 'return opening restaurants name in the specified time' do
      get '/restaurants', params: { weekday: 1, time: '10:00' }
      expect(response.body).to include restaurant.name
    end
  end
end
