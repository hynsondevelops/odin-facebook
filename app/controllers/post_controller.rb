class PostController < ApplicationController
	def new
		@post = Post.new
	end

	def create
		@post = Post.create
	end

	def edit
		@post = Post.find(params[:id])
	end

	def show
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		#@post.update_attributes(first_name: params[:post][:first_name], last_name: params[:post][:last_name])
		redirect_to @post
	end

	def index
		@users = User.all
		@signed_in = current_user
		@friend_requests = @signed_in.recieved_friend_requests
		@friends = @signed_in.friends
		@feed = @signed_in.feed
	end
end
