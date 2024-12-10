class Request < ApplicationRecord
  belongs_to :user
  has_many :activities

  validates :duration, presence: true
end
