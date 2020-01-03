class CareHomePost < ApplicationRecord
  has_many :user_care_home_posts
  has_many :users, through: :user_care_home_post
end
