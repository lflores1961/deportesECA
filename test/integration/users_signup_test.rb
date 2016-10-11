require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get acceso_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: " ",
                                          email: "user@invalid",
                                          phone: "",
                                          password:              "foo",
                                          password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
  end

  test "valid signup information" do
    get acceso_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "Example User",
                                          email: "user@example.com",
                                          phone: "449324 6565",
                                          password: "password",
                                          password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
  end
end
