class UsersController < ApplicationController
  before_action :set_user, only: [:family_room, :family_post]
  
  def index
  end

  def family_room
    @family_post = FamilyPost.new
    @family_posts = @user.family_posts.order("created_at DESC")
  end

  def family_post
    @user.family_posts.create(family_post_params)
    redirect_to family_room_user_path
   end
  
   private

   def family_post_params
     params.require(:family_post).permit(:message, :image)
   end

   def set_user
    @user = User.find(params[:id])
   end

end
