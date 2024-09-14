class Post < ApplicationRecord
  belongs_to :user
  has_many :post_moods, dependent: :destroy
  has_many :moods, through: :post_moods
  has_one_attached :post_image
  
  validates :body, presence: true

  # 投稿心着順↓
  scope :latest, -> { order(created_at: :desc) }

  def get_post_image(width,height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      post_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    post_image.variant(resize_to_fill: [width, height ]).processed
  end
  
  def today_post?
    created_at > 1.day.ago
  end
  
  def background_color
    if moods.empty?
      '#f5f5f5'
    elsif moods.size == 1
      moods.first.color
    else
      colors = moods.map(&:color).join(', ')
      "linear-gradient(to right, #{colors})"
    end
  end
end
