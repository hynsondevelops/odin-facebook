class CreateFriendLists < ActiveRecord::Migration[5.0]
  def change
    create_table :friend_lists do |t|

      t.timestamps
    end
  end
end
