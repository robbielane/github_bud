require 'test_helper'

class UserCanLoginViaGithubTest < ActionDispatch::IntegrationTest
  test "logging in" do
    VCR.use_cassette("user-login") do
      visit "/"
      assert_equal 200, page.status_code
      click_link "Login with Github"

      assert_equal "/robbielane", current_path
      assert page.has_content?("Robbie Lane")
      assert page.has_link?("Logout")
    end
  end
end
