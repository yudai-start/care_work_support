class FamilyPostsController < ApplicationController
  before_action :set_family_room

  def index
    @family_post = FamilyPost.new
    @family_posts = @family_room.family_posts.order("created_at DESC")
  end

  def create   
    @family_room.family_posts.create(family_post_params)
    redirect_to family_room_family_posts_path
  end

  private

  def family_post_params
    params.require(:family_post).permit(:message, :image).merge(family_room_id: params[:family_room_id])
  end

  def set_family_room
    @family_room = FamilyRoom.find(params[:family_room_id])
  end

end
