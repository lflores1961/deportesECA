require 'test_helper'

class DeportesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @deporte = deportes(:one)
  end

  test "should get index" do
    get deportes_url
    assert_response :success
  end

  test "should get new" do
    get new_deporte_url
    assert_response :success
  end

  test "should create deporte" do
    assert_difference('Deporte.count') do
      post deportes_url, params: { deporte: { nombre: @deporte.nombre } }
    end

    assert_redirected_to deporte_url(Deporte.last)
  end

  test "should show deporte" do
    get deporte_url(@deporte)
    assert_response :success
  end

  test "should get edit" do
    get edit_deporte_url(@deporte)
    assert_response :success
  end

  test "should update deporte" do
    patch deporte_url(@deporte), params: { deporte: { nombre: @deporte.nombre } }
    assert_redirected_to deporte_url(@deporte)
  end

  test "should destroy deporte" do
    assert_difference('Deporte.count', -1) do
      delete deporte_url(@deporte)
    end

    assert_redirected_to deportes_url
  end
end
