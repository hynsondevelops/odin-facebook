# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#Users
first_name_string = ""
last_name_string = ""
emailString = ""
passwordString = ""
for i in 1..10
  first_name_string = "firstName" + i.to_s
  last_name_string = "lastName" + i.to_s
  emailString = "email" + i.to_s + "@email.com"
  passwordString = "password" + i.to_s
  User.create!(first_name: first_name_string, last_name: last_name_string, email: emailString, password: passwordString)
end

#Pending Friend Requests
for j in 2..5
	#Friend ID 1 is sending requests to friends with ids 2 through 5
	FriendRequest.create!(friender_id: 1, friended_id: j, accepted: false)
end

#Confirmed Friend Requests, Sent
for j in 6..9
	#Friend ID 1 is sending requests to friends with ids 2 through 5
	FriendRequest.create!(friender_id: 1, friended_id: j, accepted: true)
end




#Posts
Post.create!(body: "This is a sample post body", poster_id: 2)
Post.create!(body: "This is a sample post body", poster_id: 8)
Post.create!(body: "This is a sample post body", poster_id: 1)

#LikedPosts
LikedPost.create!(post_id: 1, liker_id: 1)
LikedPost.create!(post_id: 2, liker_id: 1)
LikedPost.create!(post_id: 1, liker_id: 2)

#Comments
Comment.create!(body: "Sample Comment", post_id: 1, user_id: 4)
Comment.create!(body: "Sample Comment", post_id: 1, user_id: 3)
