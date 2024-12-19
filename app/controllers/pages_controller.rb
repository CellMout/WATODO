class PagesController < ApplicationController
  def profile
    @user = current_user
    @requests = Request.where(user_id: @user.id).order(created_at: :desc)
  end
end
