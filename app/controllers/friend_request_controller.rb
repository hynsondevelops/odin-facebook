class FriendRequestController < ApplicationController
	def new
		@friendRequest = FriendRequest.new
		@avail = current_user.notFriendsOrRequested(current_user)[0]
	end

	def create
		@friendRequest = FriendRequest.create!(friender_id: current_user.id, friended_id: params[:friend_request][:friended_id], accepted: false)
		redirect_to user_index_path
	end

	def edit
	end

	def show
		@friendRequest = FriendRequest.find(params[:id])		
	end

	def update
		@friendRequest = FriendRequest.find_by(friender_id: params[:friend_request][:friender_id], friended_id: current_user.id)
		@friendRequest.update_attributes(accepted: true)
		redirect_to user_index_path
	end

	def index
	end
end
