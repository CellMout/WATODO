class Request < ApplicationRecord
  belongs_to :user
  has_many :activities

  validates :duration, :lat, :lon, presence: true

  def response
    location = Geocoder.address([ lat, lon ])
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [ { role: "user", content: "Suggest 5 activities to do arround #{location} ,that can be done in #{duration} minutes. Each activity should have a title and a description " } ]
    })
    chatgpt_response
  end
end
