class UserController < ApplicationController
	before_action :authenticate_user!

	def new
		@user = User.new
	end

	def create
		#@user = User.create(name: "Adam")
	end

	def edit
		@user = User.find(params[:id])
	end

	def show
		@user = User.find(params[:id])
		@posts = @user.created_posts
		@signed_in = current_user
		@friend_requests = @signed_in.recieved_friend_requests
		@friends = @signed_in.friends
	end

	def update
		@user = User.find(params[:id])
		@user.update_attributes(first_name: params[:user][:first_name], last_name: params[:user][:last_name])
		redirect_to @user
	end

	def requests
		@availableUsers = current_user.notFriendsOrRequested(current_user)
		@friendRequest = FriendRequest.new
	end

	def index
		@users = current_user.notFriendsOrRequested(current_user)
		@friendRequest = FriendRequest.new
	end

	def search
		@users = []
		allUsers = User.all
		allUsers.each do |user|
			if (user.first_name.downcase == params[:search].downcase || user.last_name.downcase == params[:search].downcase)
				@users.push(user)
			end
		end
	end

end
