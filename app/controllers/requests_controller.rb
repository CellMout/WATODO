class RequestsController < ApplicationController

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(duration: (params[:request][:hours].to_i * 60 + params[:request][:minutes].to_i), lat: 43.298569, lon: 5.372766)   # changer avec strong params + localisation
    @request.user = current_user
    if @request.save!
      @request.create_activities
      redirect_to request_path(@request)
    else
      render :new, status: :unprocessable_entity, alert: "G PAS KOMPRI"
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
    params.require(:request).permit(:hours, :minutes)
  end
end
