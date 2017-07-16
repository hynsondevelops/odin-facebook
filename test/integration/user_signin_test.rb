require 'test_helper'

class UserSigninTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
      #sign up page
      get new_user_session_path
      @email = "email1@email.com"
      @password = "password1"
      @emptyString = ""
      User.create!(email: @email, password: @password, password_confirmation: @password, first_name: "fName", last_name: "lName")
  end

  test "successful signup with email and password" do
      post user_session_path, params: { user: { email: @email,
                                                password: @password,
                                                password_confirmation: @password } }
      get root_path
      #Confirms that the user page has been loaded
      #Change with formatting
      assert_select "h1", "#{@email}"
  end

  test "disallows signup with wrong password" do
      post user_session_path, params: { user: { email: @email,
                                                password: @password + "2",
                                                password_confirmation: @password } }
      #confirm that login page is still current
      assert_select "h2", "Log in"
  end



end
