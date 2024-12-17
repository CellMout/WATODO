class PagesController < ApplicationController
  def profile
    @user = current_user
    @requests = Request.where(user_id: @user.id)
  end
end
