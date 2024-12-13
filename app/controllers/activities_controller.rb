class ActivitiesController < ApplicationController

  def update
    @activity = Activity.find(params[:id])
    @activity.update!(done: true)
  end

end
