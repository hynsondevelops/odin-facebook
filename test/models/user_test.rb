require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = User.new(email: "test@email.com", password: "password")
    #Users
    @users = []
    first_name_string = ""
    last_name_string = 
    emailString = ""
    passwordString = ""
    for i in 1..10
      first_name_string = "firstName" + i.to_s
      last_name_string = "lastName" + i.to_s
      emailString = "email" + i.to_s + "@email.com"
      passwordString = "password" + i.to_s
      @users.push(User.new(first_name: first_name_string, last_name: last_name_string, email: emailString, password: passwordString))
    end

    @friend_requests = []
    for j in 2..5
      #Friend ID 1 is sending requests to friends with ids 2 through 5
      @friend_requests.push(FriendRequest.new(friender_id: 1, friended_id: j))
    end

  end 

  test "should have an email" do 
  	@user.email = ""
  	assert_not @user.valid?
  end

  test "should have a password" do
    @user.password = ""
    assert_not @user.valid?
  end

  test "should have a first name" do
    @user.first_name = ""
    assert_not @user.valid?
  end

  test "should have a last name" do
    @user.last_name = ""
    assert_not @user.valid?
  end

  test "should be able to view outgoing friend requests" do
    @users[0].sent_friend_requests.push(@friend_requests[0])
    assert_equal @users[0].sent_friend_requests[0], @friend_requests[0]
  end

  test "should be able to view users who friend requests have been sent to" do
    @friend_requests[0].friended = @users[0]
    @users[0].sent_friend_request_users.push(@friend_requests[0].friended)
    assert_equal @users[0].sent_friend_request_users[0], @friend_requests[0].friended
  end

  test "should be able to view incoming friend requests" do
    @users[0].recieved_friend_requests.push(@friend_requests[0])
    assert_equal @users[0].recieved_friend_requests[0], @friend_requests[0]
  end

  test "should be able to view users who friend requests have been recieved from" do
    @friend_requests[0].friended = @users[0]
    @users[0].recieved_friend_request_users.push(@friend_requests[0].friended)
    assert_equal @users[0].recieved_friend_request_users[0], @friend_requests[0].friended
  end

  test "should be able to view accepted friends from recieved and sent" do
    @users[0].recieved_friends.push(@users[1])
    @users[0].sent_friends.push(@users[2])
    friendsToCheck = @users[0].friends
    assert_equal friendsToCheck[0], @users[1]
    assert_equal friendsToCheck[1], @users[2]
  end


end
