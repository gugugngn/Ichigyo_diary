class Post < ApplicationRecord
  belongs_to :user
  belongs_to :mood
  has_many :message, dependent: :destroy
end
