class AskaiJob < ApplicationJob
  queue_as :default

  def perform(request)
    # Do something later
    request.create_activities
  end
end
