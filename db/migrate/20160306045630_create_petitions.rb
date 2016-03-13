class CreatePetitions < ActiveRecord::Migration
  def change
    create_table :petitions do |t|
      t.string :title
      t.string :time
      t.text :text
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
