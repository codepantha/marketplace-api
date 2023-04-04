# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class UsersControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:one)
      end

      test 'should show user' do
        get api_v1_user_url(@user), as: :json
        assert_response :success

        # test to ensure response contains the correct email
        json_response = JSON.parse(response.body)
        assert_equal @user.email, json_response['email']
      end

      test 'should create user' do
        assert_difference('User.count') do
          post api_v1_users_url, params: { user: { email: 'test@test.com', password: '123456' } }, as: :json
        end
        assert_response :created
      end

      test 'should not create user when email is taken' do
        assert_no_difference('User.count') do
          post api_v1_users_url, params: { user: { email: @user.email, password: '123456' } }, as: :json
        end
        assert_response :unprocessable_entity
      end

      test 'should update user' do
        patch api_v1_user_url(@user), params: { user: { email: @user.email, password: '123456' } }, as: :json
        assert_response :success
      end

      test 'should not update user when invalid params are set' do
        patch api_v1_user_url(@user), params: { user: { email: 'bad email', password: '123456' } }, as: :json
        assert_response :unprocessable_entity
      end
    end
  end
end