class LikedPost < ApplicationRecord
	belongs_to :liker, class_name: "User"
	belongs_to :post, class_name: "Post"
end
