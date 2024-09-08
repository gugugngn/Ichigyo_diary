class Mood < ApplicationRecord
  has_many :post_moods, dependent: :destroy
  has_many :posts, through: :post_moods
end
