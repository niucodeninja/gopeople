class CreateFriendships < ActiveRecord::Migration
  def up
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.string :status

      t.timestamps
    end

    add_index :friendships, :user_id
    add_index :friendships, :friend_id
    add_index :friendships, [:user_id, :friend_id], unique: true
  end

  def down
  	drop_table :friendships
  end
end
