class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    validates :first_name, presence: true
    validates :last_name, presence: true
    #Friend Requests
	has_many :recieved_friend_requests, -> {where accepted: false}, class_name: "FriendRequest", :foreign_key => "friended_id"
	has_many :recieved_friend_request_users, through: :recieved_friend_requests, :source => "friender"

	has_many :sent_friend_requests, -> {where accepted: false}, class_name: "FriendRequest", :foreign_key => "friender_id"
	has_many :sent_friend_request_users, through: :sent_friend_requests, :source => "friended"

	has_many :accepted_recieved_friend_requests, -> {where accepted: true}, class_name: "FriendRequest", :foreign_key => "friended_id"
	has_many :accepted_sent_friend_requests, -> {where accepted: true}, class_name: "FriendRequest", :foreign_key => "friender_id"

	has_many :recieved_friends, through: :accepted_recieved_friend_requests, :source => "friender"
	has_many :sent_friends, through: :accepted_sent_friend_requests, :source => "friended"

	has_many :created_posts, :foreign_key => "poster_id", class_name: "Post"

	has_many :liked_post_relations, class_name: "LikedPost", :foreign_key => "liker_id"
	has_many :liked_posts, through: :liked_post_relations, :source => "post"

	has_many :comments


	def friends
		return (recieved_friends + sent_friends)
	end

	def feed
		feedPosts = []
		friends.each do |friend|
			feedPosts += friend.created_posts	
		end
		return (feedPosts + created_posts)	
	end

	def allPendingRequests
		return (sent_friend_request_users + recieved_friend_request_users)
	end


	def notFriendsOrRequested(cur_user)
		print("hi")
		allRelatedUsers = sent_friend_request_users + friends
		allRelatedUsers.push(cur_user)
		allUsers = User.all
		nonIncludedUsers = []
		allUsers.each do |user|
			if (!allRelatedUsers.include?(user))
				nonIncludedUsers.push(user)
			end
		end
		return nonIncludedUsers
	end

end
