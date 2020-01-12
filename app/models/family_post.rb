class FamilyPost < ApplicationRecord
  belongs_to :family_room
  mount_uploader :image, ImageUploader
end
