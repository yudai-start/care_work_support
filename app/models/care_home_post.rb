class CareHomePost < ApplicationRecord
  has_many :user_care_home_posts, dependent: :destroy
  has_many :users, through: :user_care_home_post
  mount_uploader :image, ImageUploader
  validates :image, presence: true
end
