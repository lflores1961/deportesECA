require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Test User", email: "user@test.com",
                      password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 61
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 61 + "@test.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_adresses = %w[user@test.com USER@foo.com A_US-ER@foo.bar.org firs.last@foo.jp alex+bob@baz.cn]
    valid_adresses.each { |valid_address|
        @user.email = valid_address
        assert @user.valid?, "#{valid_address.inspect} should be valid"
      }
  end

  test "email validation should reject invalid addresses" do
    invalid_adresses = %w[user@test,com foo@bar..com user_at_foo.bar.org firs.last@foo. firs@foo_baz.com alex@bar+baz.cn]
    invalid_adresses.each { |invalid_address|
        @user.email = invalid_address
        assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
      }
  end

  test "email addresses should be unique" do
    dup_user = @user.dup
    dup_user.email = @user.email.upcase
    @user.save
    assert_not dup_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixd_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixd_case_email
    @user.save
    assert_equal mixd_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

end
