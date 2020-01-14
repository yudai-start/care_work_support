class FamilyPost < ApplicationRecord
  belongs_to :family_room
  mount_uploader :image, ImageUploader
  validates :image, presence: true
end
