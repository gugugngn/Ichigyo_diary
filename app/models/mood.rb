class Mood < ApplicationRecord
  has_many :posts, dependent: :destroy
end
