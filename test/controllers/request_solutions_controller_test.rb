require 'test_helper'

class RequestSolutionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @request_solution = request_solutions(:one)
  end

  test "should get index" do
    get request_solutions_url
    assert_response :success
  end

  test "should get new" do
    get new_request_solution_url
    assert_response :success
  end

  test "should create request_solution" do
    assert_difference('RequestSolution.count') do
      post request_solutions_url, params: { request_solution: {  } }
    end

    assert_redirected_to request_solution_url(RequestSolution.last)
  end

  test "should show request_solution" do
    get request_solution_url(@request_solution)
    assert_response :success
  end

  test "should get edit" do
    get edit_request_solution_url(@request_solution)
    assert_response :success
  end

  test "should update request_solution" do
    patch request_solution_url(@request_solution), params: { request_solution: {  } }
    assert_redirected_to request_solution_url(@request_solution)
  end

  test "should destroy request_solution" do
    assert_difference('RequestSolution.count', -1) do
      delete request_solution_url(@request_solution)
    end

    assert_redirected_to request_solutions_url
  end
end
