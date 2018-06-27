require 'rails_helper'

describe Restaurant, type: :model do
  describe '.open_at' do
    it 'return open restaurant in given weekday and time' do
      restaurant = create(:restaurant)
      create(:open_hour, restaurant: restaurant, weekday: 1, open_at: '09:00', close_at: '17:00')

      expect(described_class.open_at(1, '10:00').count).to eq 1
      expect(described_class.open_at(2, '10:00').count).to eq 0
    end
  end
end
