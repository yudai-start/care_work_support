class CreateCareHomePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :care_home_posts do |t|
      t.string     :image,   null: false
      t.string     :message
      t.timestamps
    end
  end
end
