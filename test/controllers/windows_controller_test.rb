require 'test_helper'

class WindowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @window = windows(:one)
  end

  test "should get index" do
    get windows_url
    assert_response :success
  end

  test "should get new" do
    get new_window_url
    assert_response :success
  end

  test "should create window" do
    assert_difference('Window.count') do
      post windows_url, params: { window: { message: @window.message } }
    end

    assert_redirected_to window_url(Window.last)
  end

  test "should show window" do
    get window_url(@window)
    assert_response :success
  end

  test "should get edit" do
    get edit_window_url(@window)
    assert_response :success
  end

  test "should update window" do
    patch window_url(@window), params: { window: { message: @window.message } }
    assert_redirected_to window_url(@window)
  end

  test "should destroy window" do
    assert_difference('Window.count', -1) do
      delete window_url(@window)
    end

    assert_redirected_to windows_url
  end
end
