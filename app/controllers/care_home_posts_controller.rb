class CareHomePostsController < ApplicationController
  include CommonActions

  def index
    @care_home_post = CareHomePost.new
    
    #検索フォームの変数定義
    @q = CareHomePost.ransack(params[:q])
    @care_home_posts = @q.result.order("created_at DESC")
  end

  def create
    @care_home_post = CareHomePost.create(care_home_post_params)

    #以下、awsRekognitionによる顔認証と登録済のuserとの照合
    image_path = care_home_post_params[:image].original_filename #顔認証で必要となる投稿写真のファイル名のみを抽出
    users = search_all_users_in_photo(@care_home_post, image_path)  #投稿された写真に写っている人物全員を特定
    
    if users.present? #投稿された写真と、登録されていたuserの顔が一致した場合
      save_user_care_home_posts(users, @care_home_post)  #userとcare_home_postの中間テーブルに、user_idとcare_home_post_idを保存
      send_mail(users) #各userの登録アドレスに通知メール送信

      #送信先をフラッシュメーセージで通知
      users_name = users.map{ |user| user.name + "様"}.join(', ')
      redirect_to root_path, notice: "#{users_name} のご家族に通知を送信しました" and return
    end
    redirect_to root_path
  end

  def edit
    @care_home_post = CareHomePost.find(params[:id])
  end

  def update
    care_home_post = CareHomePost.find(params[:id])
    care_home_post.update(care_home_post_params)

    if care_home_post_params[:image].present? #imageに変更があった場合、createと同様に顔認証の手順を行う
      UserCareHomePost.where(care_home_post_id: params[:id]).destroy_all #userテーブルとの中間テーブルの削除

      image_path = care_home_post_params[:image].original_filename #顔認証で必要となる投稿写真のファイル名のみを抽出
      users = search_all_users_in_photo(care_home_post, image_path)  #投稿された写真に写っている人物全員を特定し、変数usersとして定義
      
      if users.present? #投稿された写真と、登録されていたuserの顔が一致した場合
        save_user_care_home_posts(users, care_home_post)  #userとcare_home_postの中間テーブルに、user_idとcare_home_post_idを保存
        send_mail(users) #各userの登録アドレスに通知メール送信

        #送信先をフラッシュメーセージで通知
        users_name = users.map{ |user| user.name + "様"}.join(', ')
        redirect_to root_path, notice: "#{users_name} のご家族に通知を送信しました" and return
      end
    end
    redirect_to root_path
  end

  def destroy
    care_home_post = CareHomePost.find(params[:id])
    care_home_post.destroy
    redirect_to root_path
  end

  private

  def care_home_post_params
    params.require(:care_home_post).permit(:title, :image)
  end

end