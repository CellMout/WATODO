class Request < ApplicationRecord
  belongs_to :user
  has_many :activities
  validates :duration, :lat, :lon, presence: true
  validates :duration, numericality: { only_integer: true, greater_than: 0 }

  reverse_geocoded_by :lat, :lon
  after_validation :reverse_geocode

  def create_activities
    response["activities"].each do |activity|
      # loc = activity["location"] if activity["location"].split(",").count == 3
      # loc = activity["location"].split(",").drop(1).join(",") if activity["location"].split(",").count == 4
      acti = Activity.new(name: activity["title"], description: activity["description"], location: activity["location"])
      acti.request = self
      acti.save!
    end
  end

  def format_duration
     hours = duration / 60
     minutes = (duration % 60).to_s.rjust(2, "0")
     "#{hours}h #{minutes} min to kill at:"
  end

  # def postion
  #   result = request.safe_location
  # end

  private

  def response
    # location = Geocoder.address([ lat, lon ])
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      response_format: { type: "json_object" },
      messages: [ { role: "user", content: "The current time is #{Time.now.strftime("%H:%M")}. Suggest 5 activities around #{address} that can be done within #{duration} minutes. Respond in JSON format. Each activity should include:
      - 'title': a short title of the activity,
      - 'description': a short description of the activity,
      - 'location': a verified and existing address in #{address} city.
      Only provide locations that are landmarks, public places, or well-known locations (e.g., parks, museums, libraries). Do not invent addresses."
      } ],
      temperature: 0.7
    })

    json_content = chatgpt_response.dig("choices", 0, "message", "content")
    parsed_content = JSON.parse(json_content)
  end
end
