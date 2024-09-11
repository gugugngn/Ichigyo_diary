class CreatePostMoods < ActiveRecord::Migration[6.1]
  def change
    create_table :post_moods do |t|
      t.integer :post_id, null: false
      t.integer :mood_id, null: false

      t.timestamps
    end
  end
end
