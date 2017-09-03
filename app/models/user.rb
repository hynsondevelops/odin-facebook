class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]	

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

	has_attached_file :avatar, styles: {medium: "300x300>", thumb: "50x50>" }, default_url: ":style/missing.png"
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


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
		allRelatedUsers = sent_friend_request_users + friends
		allRelatedUsers.push(cur_user)
		allUsers = User.all
		nonIncludedUsers = []
		allUsers.each do |user|
			if (!allRelatedUsers.include?(user))
				nonIncludedUsers.push(user)
			end
		end
		return [nonIncludedUsers, allRelatedUsers]
	end

	def sortUserRelations
		allUsers = User.all
		allRelatedUsers = self.sent_friend_request_users + self.friends + self.recieved_friend_request_users
		allRelatedUsers.push(self)
		nonIncludedUsers = []
		allUsers.each do |user|
			if (!allRelatedUsers.include?(user))
				nonIncludedUsers.push(user)
			end
		end
		return [friends, self.sent_friend_request_users, self.recieved_friend_request_users, nonIncludedUsers]
	end

	def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.name = auth.info.name   # assuming the user model has a name
	    user.image = auth.info.image # assuming the user model has an image
	    # If you are using confirmable and the provider(s) you use validate emails, 
	    # uncomment the line below to skip the confirmation emails.
	    # user.skip_confirmation!
	  end
	end

	def self.new_with_session(params, session)
		super.tap do |user|
		  if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
		    user.email = data["email"] if user.email.blank?
		  end
		end
  	end



end
