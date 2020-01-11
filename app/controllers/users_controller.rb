class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :family_room, :family_post]
  
  def index
    @q = User.ransack(params[:q])
    @users = @q.result.where(role: "general").order("created_at DESC")
  end

  def edit
  end

  def update
    @user.update(user_params)
    #   redirect_to users_path
    # else
    #   redirect_to "users/#{@user.id}/edit"
    # end

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

   def user_params
    params.require(:user).permit(:image, :name, :email, :password, :password_confirmation)
  end

end
