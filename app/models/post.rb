class Post < ApplicationRecord
  belongs_to :user
  has_many :post_moods, dependent: :destroy
  has_many :moods, through: :post_moods
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :post_image
  
  validates :body, presence: true, length: { maximum: 40 }
  validate :one_post_per_day, on: :create
  validates :post_image, content_type: {in:[:png, :jpg, :jpeg], message: "はpng, jpg, jpegいずれかの形式にして下さい"}


  def get_post_image
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      post_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    post_image
  end
  
  # 気分が空の時、選択された気分が１つの時、選択が複数の際の条件分岐
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
  
  # いいねが重複しないように定義↓
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  private

  # 1日1投稿のバリデーション↓
  def one_post_per_day
    if Post.where(user_id: user_id, created_at: Time.zone.today.all_day).exists?
      errors.add(:base, "本日は既に投稿済みです")
    end
  end
end
