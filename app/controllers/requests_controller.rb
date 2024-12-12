class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def create
    @request = Request.new(duration: (params[:request][:hours].to_i * 60 + params[:request][:minutes].to_i), lat: params[:request][:latitude], lon: params[:request][:longitude])   # changer avec strong params + localisation
    @request.user = current_user
    if @request.save!
      @request.create_activities
      redirect_to request_path(@request)
    else
      render :new, status: :unprocessable_entity, alert: "Can't process your request"
    end
  end

  def show
    @markers = Array.new(5)
    @request = Request.find(params[:id])
    @markers = @request.activities do |activity|
      {
        lat: activity.longitude,
        lng: activity.latitude,
        info_window_html: render_to_string(partial: "info_window", locals: { activity: activity })
      }
    end
  end

  def edit
  end

  def update
  end

  private


  def request_params
    params.require(:request).permit(:hours, :minutes, :latitude, :longitude)
  end
end
