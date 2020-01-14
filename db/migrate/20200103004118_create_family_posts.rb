class CreateFamilyPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :family_posts do |t|
      t.string   :image,            null: false
      t.string   :title
      t.integer  :family_room_id,  foreign_key: true
      t.timestamps
    end
  end
end
