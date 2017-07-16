class CreateLikedPosts < ActiveRecord::Migration[5.0]
  def change
    create_table :liked_posts do |t|
    	t.integer :liker_id
    	t.integer :post_id

      t.timestamps
    end
  end
end
