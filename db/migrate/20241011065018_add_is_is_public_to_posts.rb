class AddIsIsPublicToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :is_public, :boolean, default: true
  end
end
