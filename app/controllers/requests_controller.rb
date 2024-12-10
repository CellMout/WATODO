class RequestsController < ApplicationController

    def new
      @request = Request.new
    end

    def create
    @request = Request.new(params[:request])
      if @request.save
        redirect_to @request
      else
        render :new
      end
    end

    def show
      @request = Request.find(params[:id])
    end

    def edit
    end

    def update
    end

  private


    def request_params
      params.require(:request).permit(:user_id, :duration, :lat, :lon, :options, :category)
    end
end
