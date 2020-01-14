class UsersController < ApplicationController
  
  def index
    @q = User.ransack(params[:q])
    @users = @q.result.where(role: "general").order("created_at DESC")
  end
  
end
