class UsersController < ApplicationController
  before_action :set_search, only: [:index]
  
  def index
  end

  private

  def set_search
    @q = User.ransack(params[:q])
    @users = @q.result.where(role: "general").order("created_at DESC")
  end

end
