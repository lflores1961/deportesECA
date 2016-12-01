require 'test_helper'

class AsistenciasControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get asistencias_create_url
    assert_response :success
  end

  test "should get new" do
    get asistencias_new_url
    assert_response :success
  end

end
