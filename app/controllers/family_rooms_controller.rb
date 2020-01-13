class FamilyRoomsController < ApplicationController
 
  def index
    @q = FamilyRoom.ransack(params[:q])
    @family_rooms = @q.result.order("created_at DESC")
  end
end
