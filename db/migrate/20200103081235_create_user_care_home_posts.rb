class CreateUserCareHomePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :user_care_home_posts do |t|
      t.references :care_home_post, foreign_key: true
      t.references :user,           foreign_key: true
      t.timestamps
    end
  end
end
