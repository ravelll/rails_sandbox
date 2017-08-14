require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  def setup
    @unactivated = users(:malory)
    @activated = users(:michael)
    log_in_as(@activated)
  end

  test "show activated user page" do
    get user_path(@activated)
    assert_template 'users/show'
  end

  test "show unactivated user page" do
    get user_path(@unactivated)
    assert_redirected_to root_url
  end
end
