class CreateFamilyRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :family_rooms do |t|
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
