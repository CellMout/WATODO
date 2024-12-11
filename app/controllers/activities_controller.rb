class ActivitiesController < ApplicationController
  def update
  end

  def index
  @activities = Activity.all
    @markers = @activity.geocoded.map do |activity|
      {
        lat: Geocoder.search(@activity.location).first.coordinates[0],
        lng: Geocoder.search(@activity.location).first.coordinates[1],
        info_window_html: render_to_string(partial: "info_window", locals: {activity: activity})
      }
    end
  end
end
