class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def create
    @request = Request.new(duration: (params[:request][:hours].to_i * 60 + params[:request][:minutes].to_i), lat: params[:request][:latitude], lon: params[:request][:longitude])
    if user_signed_in?
      @request.user = current_user
    else
      @request.user = User.find_by(email: "default.user@watodo.bug")
    end

    if @request.save
      AskaiJob.perform_now(@request)
      redirect_to request_path(@request)
    else
      flash[:alert] = "Location permission must be on and you have to set a time frame"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # @markers = []
    @request = Request.find(params[:id])
    @markers = @request.activities.map do |activity|
      {
        lat: activity.latitude,
        lng: activity.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { activity: activity }),
        type: "activity"
      }
    end

    if @request
      @markers << {
        lat: @request.lat,
        lon: @request.lon,
        info_window_html: render_to_string(partial: "info_window", locals: { activity: Activity.first }),
        type: "user"
      }
    end
  end
  def archive
    @request = Request.find(params[:id])
    @request.update(archived: true)  # Assure-toi d'avoir un attribut "archived" dans ta base de données
    redirect_to profile_path
  end

  def edit
  end

  def update
  end

  private

  def request_params
    params.require(:request).permit(:hours, :minutes, :latitude, :longitude, :archived)
  end
end
