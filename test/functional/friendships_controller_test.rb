require 'test_helper'

class FriendshipsControllerTest < ActionController::TestCase
  test "should get requests" do
    get :requests
    assert_response :success
  end

  test "should get invites" do
    get :invites
    assert_response :success
  end

end
