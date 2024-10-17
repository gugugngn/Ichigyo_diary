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

test_user = User.find_or_create_by!(email: "test@aaa.jp") do |user|
  user.name = "てすと"
  user.password = "123456"
  user.password_confirmation = "123456"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.png"), filename:"sample-user1.png")
end

seigi = User.find_or_create_by!(email: "seigi@example.com") do |user|
  user.name = "正義"
  user.password = "S22222"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.png"), filename:"sample-user2.png")
end

bushi = User.find_or_create_by!(email: "bushi@example.com") do |user|
  user.name = "Bushi"
  user.password = "b33333"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.png"), filename:"sample-user3.png")
end



# Moodデータの中身
moods_data = [
   { name: "楽しい", color: "#f6bfbc" },
   { name: "ワクワク", color: "#f6ad49" },
   { name: "感謝", color: "#f7bd8f" },
   { name: "面白い", color: "#f4aa86" },
   { name: "満足", color: "#f2a0a1" },
   { name: "ドキドキ", color: "#f0908d" },
   { name: "普通", color: "#ebd842" },
   { name: "スッキリ", color: "#b9d08b" },
   { name: "退屈", color: "#ebe1a9" },
   { name: "穏やか", color: "#c1d8ac" },
   { name: "モヤモヤ", color: "#e4dc8a" },
   { name: "緊張", color: "#df7163" },
   { name: "イライラ", color: "#e45e32" },
   { name: "後悔", color: "#c4a3bf" },
   { name: "不安", color: "#abced8" },
   { name: "悲しい", color: "#8491c3" },
   { name: "疲れた", color: "#a59aca" },
   { name: "お腹すいた", color: "#e6b422" },
]


moods_data.each do |mood_data|
  Mood.find_or_create_by!(name: mood_data[:name]) do |mood|
    mood.color = mood_data[:color]
  end
end


# 投稿データの配列
posts_data = [
  {
    user: test_user,
    body: "今日はとっても疲れた１日だった。元気が出るように食事は豪華にした〜",
    message: "明日も頑張ってね。",
    image_path: "#{Rails.root}/db/fixtures/sample-post1.jpeg",
    image_filename: "sample-post1.jpeg",
    mood_ids: [12,17],
    created_at: 1.days.ago
  },
  {
    user: test_user,
    body: "1日天気悪くて頭痛かった、晴れてほしいいいい",
    message: "天気が晴れることを願ってる",
    mood_ids: [11,13,17],
    created_at: 2.days.ago
  },
  {
    user: test_user,
    body: "今日はジム行ったよ、トレーナーさんに褒められた、嬉しい〜",
    image_path: "#{Rails.root}/db/fixtures/sample-post1-2.jpg",
    image_filename: "sample-post1-2.jpg",
    mood_ids: [1,2,5],
    created_at: 3.days.ago
  },
   {
    user: test_user,
    body: "何もやる気出ない、日記書けただけ偉いよ",
    message: "ゆっくり休んでね",
    mood_ids: [17],
    created_at: 4.days.ago
  },
  {
    user: test_user,
    body: "なんか以上にお腹すいて、気づいたら1日5食食べてたよ。。。おそろし",
    message: "食べ過ぎ注意報",
    mood_ids: [6,18],
    created_at: 5.days.ago
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
    p.created_at = post_data[:created_at]  # 過去の日付を設定
    
    if post_data[:image_path].present?  # 画像が存在する場合のみ
      p.post_image.attach(
        io: File.open(post_data[:image_path]),
        filename: post_data[:image_filename]
      )
    end
  end
  
  # バリデーション無効で保存
  post.save(validate: false)

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