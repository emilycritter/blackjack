require 'test_helper'

class PlayControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get hit" do
    get :hit
    assert_response :success
  end

  test "should get winner" do
    get :winner
    assert_response :success
  end

end
