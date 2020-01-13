class FamilyRoom < ApplicationRecord
  has_many :family_posts
  belongs_to :user
end
