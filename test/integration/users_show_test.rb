require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  def setup
    @inactivated = users(:inactivated)
    @activated = users(:michael)
    log_in_as(@activated)
  end

  test "show activated user page" do
    get user_path(@activated)
    assert_template 'users/show'
  end

  test "show inactivated user page" do
    get user_path(@inactivated)
    assert_redirected_to root_url
  end
end
