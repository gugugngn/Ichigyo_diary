class Post < ApplicationRecord
  belongs_to :user
  has_many :post_moods, dependent: :destroy
  has_many :moods, through: :post_moods
  has_many :messages, dependent: :destroy
  has_one_attached :post_image
  
  
  def get_post_image(width,height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      post_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_fill: [width, height ]).processed
  end
end
