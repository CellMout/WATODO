class Request < ApplicationRecord
  belongs_to :user
  has_many :activities
end
