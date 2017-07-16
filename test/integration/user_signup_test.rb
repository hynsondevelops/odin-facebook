require 'test_helper'

class UserSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
      #sign up page
      get new_user_registration_path
      @firstName = "firstName"
      @lastName = "lastName"
      @email = "sample@email.com"
      @password = "password"
      @emptyString = ""
  end

  test "sign up requires first name" do
      assert_no_difference 'User.count' do
        post user_registration_path, params: { user: { first_name: @emptyString,
                                                  last_name: @lastName,
                                                  email: @email,
                                                  password: @password,
                                                  password_confirmation: @password } }
      end
  end

  test "sign up requires last name" do
      assert_no_difference 'User.count' do
        post user_registration_path, params: { user: { first_name:  @firstName,
                                                  last_name: @emptyString,
                                                  email: @email,
                                                  password: @password,
                                                  password_confirmation: @password } }
      end
  end

  test "sign up requires email" do
      assert_no_difference 'User.count' do
        post user_registration_path, params: { user: { first_name:  @firstName,
                                                  last_name: @lastName,
                                                  email: @emptyString,
                                                  password: @password,
                                                  password_confirmation: @password } }
      end
  end

  test "sign up requires password" do
      assert_no_difference 'User.count' do
        post user_registration_path, params: { user: { first_name:  @firstName,
                                                  last_name: @lastName,
                                                  email: @email,
                                                  password: @emptyString,
                                                  password_confirmation: @password } }
      end
  end

  test "sign up requires password confirmation" do
      assert_no_difference 'User.count' do
        post user_registration_path, params: { user: { first_name:  @firstName,
                                                  last_name: @lastName,
                                                  email: @email,
                                                  password: @password,
                                                  password_confirmation: @emptyString } }
      end
  end

  test "successful signup" do
      assert_difference 'User.count', 1 do
        post user_registration_path, params: { user: { first_name:  @firstName,
                                                  last_name: @lastName,
                                                  email: @email,
                                                  password: @password,
                                                  password_confirmation: @password } }
      end
  end



end
