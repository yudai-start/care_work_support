class CreateFamilyPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :family_posts do |t|
      t.string     :image,   null: false
      t.string     :message
      t.references :user,    foreign_key: true
      t.timestamps
    end
  end
end
