class AddRandomHashToChatRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :chat_rooms, :random_hash, :string
  end
end
