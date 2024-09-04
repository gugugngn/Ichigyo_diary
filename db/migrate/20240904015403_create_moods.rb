class CreateMoods < ActiveRecord::Migration[6.1]
  def change
    create_table :moods do |t|
      t.string :name, null: false
      t.string :color, null: false

      t.timestamps
    end
  end
end
