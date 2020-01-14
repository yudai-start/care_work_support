module CommonActions
  extend ActiveSupport::Concern

  require "aws-sdk-rekognition"

  def client #rekognitionの認証のため
    @rekog = Aws::Rekognition::Client.new(
      region: 'ap-northeast-1',
      access_key_id: Rails.application.credentials[:aws][:access_key_id],
      secret_access_key: Rails.application.credentials[:aws][:secret_access_key]
      )
  end

  def registration_face(image_path)   #写真に写っている全ての人物のface_idを取得しrekognitionに登録

    begin
      result = client.index_faces({    #rekoognitonのface_id取得API
        collection_id: "care_work_support",
        image: {
          s3_object: {
            bucket: "care-work-support",
            name: "uploads/#{image_path}",
          },
        }
      })
      face_ids = result[:face_records].map{ |r| r[:face][:face_id]} #APIからのレスポンスのうち、face_idのみを抽出し配列化
        
    rescue
      face_ids = [] #エラー時はface_idなしとして取り扱う
    end
  end

  def search_face(face_id) #一つのface_idに対し、登録されているユーザーの全てのface_idから、最も一致率の高いface_idを抽出

    begin
      result = client.search_faces({
        collection_id: "care_work_support",
        face_id: "#{face_id}",
        face_match_threshold: 50
      })

      match_face_id = result[:face_matches][0][:face][:face_id] #APIからのレスポンスのうち、face_idのみを抽出

    rescue
      match_face_id = "" #エラー時は、一致なしとして取り扱う
    end

  end
 
  def search_all_users_in_photo(image_path) #一つの写真に写っている全ての人物に対し、登録されているユーザーの全てのface_idから、最も一致率の高いface_idを抽出

    face_ids = registration_face(image_path)
    if face_ids.present?
      match_face_ids = face_ids.map do |face_id|
        search_face(face_id)
      end
      delete_face_id_from_rekog(face_ids) #一ユーザーに対しface_idを一つに制限するため、registration_faceで登録したface_idの削除
      match_face_ids = match_face_ids.reject(&:blank?) #nilと空文字を削除
      if match_face_ids.present?
        users = match_face_ids.map do |match_face_id| #match_face_idsの各idに一致するユーザーを抽出
          User.find_by(face_id: match_face_id) 
        end
        users = users.reject(&:blank?) #nilと空文字を削除
      else
        users = []
      end
    else
      users = []
    end
  end

  def delete_face_id_from_rekog(face_ids)
    client.delete_faces({
      collection_id: "care_work_support", 
      face_ids: face_ids,
    })
  end

  def save_face_id(face_ids, user)
    user.face_id  = face_ids[0]
    user.save
  end

  def save_matched_faces(matched_face_ids, post)
    matched_face_id = face_ids[0]
    profile.face_id = "#{matched_face_id}"
  end

  def save_user_care_home_posts(users, care_home_post)
    users.each do |user|
      care_home_post.user_care_home_posts.create(user_id: user.id)
    end
  end

  def send_mail(users)
    users.each do |user|
      NotificationMailer.notice_care_home_post_mail(user).deliver_later
    end
  end
end