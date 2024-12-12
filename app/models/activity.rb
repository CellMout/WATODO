class Activity < ApplicationRecord
  belongs_to :request

  validates :latitude, :longitude, presence: true, numericality: true
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
