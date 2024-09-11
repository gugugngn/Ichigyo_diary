class PostMood < ApplicationRecord
  belongs_to :post
  belongs_to :mood
end
