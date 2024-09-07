class MessageText < ApplicationRecord
  has_many :messages,dependent: :destroy
end
