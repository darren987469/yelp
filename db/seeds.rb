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

    %i[sun mon tue wed thu fri sat].each_with_index do |weekday, index|
      restaurant.open_hours.create!(weekday: index, open_at: data['hours']["#{weekday}_1_open"], close_at: data['hours']["#{weekday}_1_close"])
    end
  end

  puts "Total create #{Restaurant.count} Restaurants"
  puts "Total create #{OpenHour.count} OpenHours"
end

if Restaurant.count.zero?
  ActiveRecord::Base.transaction do
    import_data
  end
end
