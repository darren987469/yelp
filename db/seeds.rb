# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def import_data
  file = File.read('test/fixtures/files/restaurants_data.json')
  JSON.parse(file).each do |data|
    restaurant = Restaurant.create!(name: data['name'], fid: data['id'])

    # FIXME: temp work around, cross day data
    if data['name'] == 'Toast'
      import_toast_data(restaurant)
      next
    end

    %i[mon tue wed thu fri sat sun].each do |weekday|
      restaurant.open_hours.create!(weekday: weekday, open_at: data['hours']["#{weekday}_1_open"], close_at: data['hours']["#{weekday}_1_close"])
    end
  end

  puts "Total create #{Restaurant.count} Restaurants"
  puts "Total create #{OpenHour.count} OpenHours"
end

def import_toast_data(restaurant)
  restaurant.open_hours.create!(weekday: :mon, open_at: '00:00', close_at: '12:00')
  restaurant.open_hours.create!(weekday: :mon, open_at: '17:30', close_at: '24:00')
  restaurant.open_hours.create!(weekday: :tue, open_at: '00:00', close_at: '11:30')
  restaurant.open_hours.create!(weekday: :tue, open_at: '17:30', close_at: '24:00')
  restaurant.open_hours.create!(weekday: :wed, open_at: '00:00', close_at: '11:30')
  restaurant.open_hours.create!(weekday: :wed, open_at: '17:30', close_at: '24:00')
  restaurant.open_hours.create!(weekday: :thu, open_at: '00:00', close_at: '11:30')
  restaurant.open_hours.create!(weekday: :thu, open_at: '17:30', close_at: '24:00')
  restaurant.open_hours.create!(weekday: :fri, open_at: '00:00', close_at: '11:30')
  restaurant.open_hours.create!(weekday: :fri, open_at: '17:30', close_at: '24:00')
  restaurant.open_hours.create!(weekday: :sat, open_at: '00:00', close_at: '11:30')
  restaurant.open_hours.create!(weekday: :sat, open_at: '15:30', close_at: '24:00')
  restaurant.open_hours.create!(weekday: :sun, open_at: '00:00', close_at: '12:00')
  restaurant.open_hours.create!(weekday: :sun, open_at: '15:30', close_at: '24:00')
end

if Restaurant.count.zero?
  ActiveRecord::Base.transaction do
    import_data
  end
end
