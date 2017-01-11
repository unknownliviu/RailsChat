class ChatRoom < ApplicationRecord
  belongs_to :user

  has_many :messages, dependent: :destroy

  validates :title, presence: true

  before_save do
    self.random_hash = SecureRandom.hex(4)
  end
end
