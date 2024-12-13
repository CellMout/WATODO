class Activity < ApplicationRecord
  belongs_to :request

  validates :location, presence: true
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  def gmaps_params
    self.location.split(',').join('%2C').split(' ').join('+')
  end
end
