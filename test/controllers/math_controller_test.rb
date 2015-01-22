require 'test_helper'

class MathControllerTest < ActionController::TestCase
  test "should get operation" do
    get :operation
    assert_response :success
  end

end
