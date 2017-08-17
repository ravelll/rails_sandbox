require 'test_helper'

class LoggedInHomeTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
    log_in_as(@user)
  end

  test "logged in home page" do
    get root_url

    assert_template 'static_pages/home'
    assert_select 'title', full_title
    assert_select 'h1', text: @user.name
    assert_select 'a[href=?]', user_path(@user)
    assert_select 'section.user_info>a>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination', count: 1
    @user.feed.paginate(page: 1).each do |micropost|
      assert_match CGI.escape_html(micropost.content), response.body
    end

    assert_select 'strong#following', count: 1, text: /#{@user.following.count}/
    assert_select 'strong#followers', count: 1, text: /#{@user.followers.count}/
  end
end
