class Message < ApplicationRecord
  belongs_to :post
  belongs_to :sender, class_name: "User", foreign_key: "sender_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"
  
  enum body: { keep_going: 0, cheer_up: 1,  good_job: 2, good_day_to: 3 }
end