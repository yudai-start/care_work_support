class CareHomePostsController < ApplicationController
  include CommonActions

  def index
    @care_home_post = CareHomePost.new
    @care_home_posts = CareHomePost.all.order("created_at DESC")
  end

  def create
    @care_home_post = CareHomePost.create(care_home_post_params)

    image_path = care_home_post_params[:image].original_filename #顔認証で必要となる投稿写真のファイル名のみを抽出
    users = search_all_users_in_photo(image_path)  #投稿された写真に写っている人物全員を特定
    if users.present?
      save_user_care_home_posts(users, @care_home_post)  #userとcare_home_postの中間テーブルに、user_idとcare_home_post_idを保存
      send_mail(users) #各userの登録アドレスに通知メール送信
    end
    redirect_to root_path
    # , notice: users.name + "様のご登録先へ通知しました"
  end

  def care_home_post_params
    params.require(:care_home_post).permit(:message, :image)
  end
end