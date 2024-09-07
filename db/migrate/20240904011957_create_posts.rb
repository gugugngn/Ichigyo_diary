class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :mood_id
      t.text :body, null: false
      t.text :message
      t.date :date, null: false

      t.timestamps
    end
  end
end
