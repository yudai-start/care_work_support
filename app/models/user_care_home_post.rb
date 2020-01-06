class UserCareHomePost < ApplicationRecord
  belongs_to :user
  belongs_to :care_home_post
end
