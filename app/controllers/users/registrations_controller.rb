# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  include CommonActions
  prepend_before_action :require_no_authentication, only: [:cancel]

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
    if resource.persisted? #登録が成功した場合に続く処理
      image_path = image_params[:image].original_filename
      face_ids = registration_face(image_path) #写真に写っている全ての人物のface_idを取得しrekognitionに登録
      if face_ids.present?
        save_face_id(face_ids, @user) #face_idsから、最も一致率の高い人物のface_idを抜き出し、userテーブルに登録
        @user.build_family_room.save #ユーザー専用のfamily_roomを生成
    
        #登録完了のnotice

      else
        @user.destroy
    #「登録ができません。写真を変更してください」のアラート
    
      end
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

protected
  def current_user_is_admin?
    user_signed_in? && current_user.role == "admin"
  end

  def sign_up(resource_name, resource)
    if !current_user_is_admin?
      sign_in(resource_name, resource)
    end
  end

  def image_params
    params.require(:user).permit(:image)
  end
  
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    users_path
  end
  #   super(resource)
  #     if @user.face_id.present?
  #       root_path
  #     else
  #       new_user_registration_path
  #     end
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
