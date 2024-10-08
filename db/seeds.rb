# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.find_or_create_by(id: 1) do |admin|
  admin.email = "admin@example.com"
  admin.password = "A123456"
  admin.password_confirmation = "A123456"
end

momoko = User.find_or_create_by!(email: "momoko@example.com") do |user|
  user.name = "ももこ"
  user.password = "m11111"
  user.password_confirmation = "m11111"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

seigi = User.find_or_create_by!(email: "seigi@example.com") do |user|
  user.name = "正義"
  user.password = "S22222"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

bushi = User.find_or_create_by!(email: "bushi@example.com") do |user|
  user.name = "Bushi"
  user.password = "b33333"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end



# Moodデータの中身
moods_data = [
   { name: "幸せ", color: "#fbe2eb" },
   { name: "楽しい", color: "#fde2a6" },
   { name: "絶好調", color: "#f09597" },
   { name: "ワクワク", color: "#f4aa86" },
   { name: "スッキリ", color: "#ebf5e9" },
   { name: "普通", color: "#eee900" },
   { name: "モヤモヤ", color: "#89c122" },
   { name: "イライラ", color: "#ff4d4d" },
   { name: "悲しい", color: "#c6dbee" },
   { name: "疲れた", color: "#e4dfef" },
   
]


moods_data.each do |mood_data|
  Mood.find_or_create_by!(name: mood_data[:name]) do |mood|
    mood.color = mood_data[:color]
  end
end


# 投稿データの配列
posts_data = [
  {
    user: momoko,
    body: "今日はとっても疲れた１日だった。元気が出るように食事は豪華にした〜",
    message: "明日も頑張ってね。",
    image_path: "#{Rails.root}/db/fixtures/sample-post1.jpg",
    image_filename: "sample-post1.jpg",
    mood_ids: [3]
  },
  {
    user: seigi,
    body: "海に行ったあらいい写真が撮れた。永久保存版",
    message: "明日も頑張っていこう。",
    image_path: "#{Rails.root}/db/fixtures/sample-post2.jpg",
    image_filename: "sample-post2.jpg",
    mood_ids: [1, 2]
  },
  {
    user: bushi,
    body: "綺麗な夕焼けだ",
    message: "明日も頑張ろう。",
    image_path: "#{Rails.root}/db/fixtures/sample-post3.jpg",
    image_filename: "sample-post3.jpg",
    moods_ids: []
  }
]

# 投稿データの作成とMoodの関連付け
posts_data.each do |post_data|
  post = Post.find_or_create_by!(user: post_data[:user], body: post_data[:body]) do |p|
    p.message = post_data[:message]
    p.post_image.attach(
      io: File.open(post_data[:image_path]),
      filename: post_data[:image_filename]
    )
  end

  # mood_idsの関連付け
  if post_data[:mood_ids].present?
    moods = Mood.where(id: post_data[:mood_ids])
    post.moods = moods
    post.save!
  end
end


  
  # 明日へのメッセージ＆小さなエールの配列
  message_texts = [
    { content: "今日も１日お疲れ様でした。明日もいい日になりますように。"},
    { content: "今日も１日お疲れ様でした！明日もマイペースに頑張りましょう。"},
    { content: "素敵な日記ですね！元気をもらえました、ありがとうございます。"},
    { content: "今日も１日お疲れ様でした。明日はごゆっくりなさってください。"}
    ]
  
  message_texts.each do |message_text|
    MessageText.find_or_create_by!(content: message_text[:content])
  end
  
  to_messages = [
    { 
      sender_id: 1,
      receiver_id: 2,
      message_text_id: 1 
    },
    { 
      sender_id: 2,
      receiver_id: 1,
      message_text_id: 3 
    },
   ]
  
  to_messages.each do |to_message|
    Message.find_or_create_by!(sender_id: to_message[:sender_id], receiver_id: to_message[:receiver_id], message_text_id: to_message[:message_text_id])
  end
  