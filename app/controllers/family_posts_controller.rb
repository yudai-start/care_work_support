class FamilyPostsController < ApplicationController
 def index
  @family_posts = FamilyPost.where(user_id: current_user.id).includes(:user)
 end

 def create
  # binding.pry
  @family_post = FamilyPost.create(family_post_params)
  redirect_to family_posts_path
 end

 private

 def family_post_params
   params.permit(:message, :image).merge(user_id: current_user.id)
 end

end
