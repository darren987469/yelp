class Restaurant < ApplicationRecord
  has_many :open_hours

  scope :open_at, lambda { |weekday, time|
    # rubocop:disable Metrics/LineLength
    joins(:open_hours).where(
      %(
        (open_hours.weekday = :weekday AND :time >= open_hours.open_at AND :time < open_hours.close_at) OR
        ((open_hours.weekday = :yesterday AND :time >= open_hours.open_at) AND (open_hours.weekday = :weekday AND :time < open_hours.close_at))
      ), weekday: weekday, time: time, yesterday: (weekday.to_i + 1) % 7
    )
    # rubocop:enable Metrics/LineLength
  }
end
