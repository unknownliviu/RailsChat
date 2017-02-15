# == Schema Information
#
# Table name: chat_rooms
#
#  id           :integer          not null, primary key
#  title        :string
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  random_hash  :string
#  recipient_id :integer
#

class ChatRoom < ApplicationRecord
  belongs_to :user
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id, optional: true

  has_many :messages, dependent: :destroy

  validates :title, presence: true
  validates :user_id, uniqueness: {scope: :recipient_id, message: 'only one valid pair'}

  scope :for_user, -> (id) {where('user_id = ? or recipient_id = ?', id, id).uniq}

  before_save do
    self.random_hash = SecureRandom.hex(4)
  end
end
