class CreateFriendRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :friend_requests do |t|
    	t.integer :friender_id
    	t.integer :friended_id
    	t.boolean :accepted, :default => false
      t.timestamps
    end
  end
end
