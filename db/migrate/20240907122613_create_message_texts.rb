class CreateMessageTexts < ActiveRecord::Migration[6.1]
  def change
    create_table :message_texts do |t|
      t.string :content

      t.timestamps
    end
  end
end
