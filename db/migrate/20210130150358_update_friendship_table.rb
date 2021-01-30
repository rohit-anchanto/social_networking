class UpdateFriendshipTable < ActiveRecord::Migration[5.2]
  def change
    remove_reference :friendships, :friend
    remove_reference :friendships, :user
    add_reference :friendships, :sent_by, foreign_key: { to_table: :users }
    add_reference :friendships, :sent_to, foreign_key: { to_table: :users }
    add_column :friendships, :status, :boolean, default:false
  end
end
