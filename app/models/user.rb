class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
 has_many :posts, dependent: :destroy
 has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
 has_many :received_messages, class_name: "Message", foreign_key: "receiver_id"
 has_many :comments, dependent: :destroy
 has_many :favorites, dependent: :destroy
 has_one_attached :profile_image
 
  validates :name, presence: true
  
  # ゲストログインユーザーの記述↓
  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end
  
  def guest_user?
    email == GUEST_USER_EMAIL
  end
  
  # プロフィール画像のサイズ調整定義＆デフォルト画像の差し込み
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_fill: [width, height]).processed
  end
  
  def self.search_for(content,method)
    if method == 'perfect'
      User.where(name: content)
    else
      User.where('name LIKE ?', '%' +  content  + '%')
    end
  end
end
