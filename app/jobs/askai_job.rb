class AskaiJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts "asking AI to do something"
    sleep 5
    puts "job done!"
  end
end
