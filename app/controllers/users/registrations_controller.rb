# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:cancel]
  before_action :creatable?, only: [:new, :create]

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
    image_path = image_params[:image].original_filename
    face_ids = registration_face(image_path)
    if face_ids.present?
      save_face_id(face_ids, @user)
    else
      @user.destroy
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

    def creatable?
      raise CanCan::AccessDenied unless user_signed_in?

      if !current_user_is_admin?
        raise CanCan::AccessDenied
      end
    end

    def image_params
      params.require(:user).permit(:image)
    end

    def registration_face(image_path)
      #写真に写っている全ての人物のface_idを抜き出し、rekognitionに登録
      require "aws-sdk-rekognition"

      rekog = Aws::Rekognition::Client.new(
        region: 'ap-northeast-1',
        access_key_id: Rails.application.credentials[:aws][:access_key_id],
        secret_access_key: Rails.application.credentials[:aws][:secret_access_key]
        )
  
      begin
        result = rekog.index_faces({
          collection_id: "care_work_support",
          image: {
            s3_object: {
              bucket: "care-work-support",
              name: "uploads/user/image/#{image_path}",
            },
          }
        })

        face_ids = result[:face_records].map{ |face| [face[:face][:face_id]]}
      
      rescue
        face_ids = []
      end
    end

    def save_face_id(face_ids, user)
      user.face_id  = face_ids[0][0] #face_idsから、最も一致率の高い人物のface_idを抜き出し、userテーブルに登録
      user.save
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
  # def after_sign_up_path_for(resource)
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
