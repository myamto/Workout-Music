require 'test_helper'

class WorkoutControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get workout_index_url
    assert_response :success
  end

end
