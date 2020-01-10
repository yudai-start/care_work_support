class FamilyPostsController < ApplicationController
 def index
  @family_post = FamilyPost.new
  if current_user.role == "admin"
    @family_posts = FamilyPost.all.order("created_at DESC").includes(:user)
  else
    @family_posts = FamilyPost.where(user_id: current_user.id).order("created_at DESC").includes(:user)
  end
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
