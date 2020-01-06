class FamilyPostsController < ApplicationController
 def index
  @family_post = FamilyPost.new
  @family_posts = FamilyPost.where(user_id: current_user.id).includes(:user)
 end

 def create
  @family_post = FamilyPost.create(family_post_params)
  redirect_to family_posts_path
 end

 private

 def family_post_params
   params.require(:family_post).permit(:message, :image).merge(user_id: current_user.id)
 end

end
