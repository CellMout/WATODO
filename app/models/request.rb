class Request < ApplicationRecord
  belongs_to :user
  has_many :activities

  validates :duration, :lat, :lon, presence: true

  def create_activities
    response["activities"].each do |activity|
      acti = Activity.new(name: activity["title"], description: activity["description"], location: activity["location"])
      acti.request = self
      acti.save!
    end
  end

  private

  def response
    location = Geocoder.address([ lat, lon ])
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      response_format: { type: "json_object" },
      messages: [ { role: "user", content: "Suggest 5 activities to do arround #{location}, that can be done in #{duration} minutes. Respond in json each activity should have a title a description and a location" } ],
      temperature: 0.7
    })

    json_content = chatgpt_response.dig("choices", 0, "message", "content")
    parsed_content = JSON.parse(json_content)
  end
end
