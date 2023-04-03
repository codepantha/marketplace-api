require "test_helper"

class UserTest < ActiveSupport::TestCase
  describe "#valid?" do
    test "is valid when email is valid" do
      user = User.new(email: 'test@test.com', password_digest: 'test')
      assert user.valid?
    end

    test "is invalid when email is invalid" do
      user = User.new(email: 'test', password_digest: 'test')
      assert_not user.valid?
    end

    test "is invalid if the email is taken" do
      user1 = users(:one)
      user2 = User.new(email: 'test@test.com', password_digest: 'test')
      assert_not user2.valid?
    end
  end
end
