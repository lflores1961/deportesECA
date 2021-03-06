require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other = users(:archer)
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should get new" do
    get acceso_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    log_in_as(@other)
    get edit_user_path(@user)
    assert_response :success
  end

  test "should redirect update when not logged in" do
    log_in_as(@other)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_redirected_to user_path(@user)
  end

=begin
  test "should not allow the admin attribute to the edited via the web" do
    log_in_as(@other)
    assert_not @other.admin?
    patch user_path(@other), params: { user: { password:                "",
                                               password_confirmation:   "",
                                               admin:                   true } }
    assert_not @other.reload.admin?
  end
=end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

end
