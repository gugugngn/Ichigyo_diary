class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      # senderもreceiverもuser由来のためintegerからreference型に変更した
      t.references :sender, null: false, foreign_key: { to_table: :users }
      t.references :receiver, null: false, foreign_key: { to_table: :users }
      t.integer:body, null: false

      t.timestamps
    end
  end
end
