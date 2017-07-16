class Post < ApplicationRecord
	belongs_to :poster, class_name: "User"

	has_many :liked_post_relations, class_name: "LikedPost", :foreign_key => "post_id"
	has_many :likers, through: :liked_post_relations, :source => "liker"
  
  	has_many :comments
  	
end
