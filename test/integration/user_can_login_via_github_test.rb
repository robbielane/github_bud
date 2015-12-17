require 'test_helper'

class UserCanLoginViaGithubTest < ActionDispatch::IntegrationTest
  test "logging in" do
    VCR.use_cassette("user-profile") do
      visit "/"
      assert_equal 200, page.status_code
      click_link "Login with Github"

      assert_equal "/robbielane", current_path
      assert page.has_content?("Robbie Lane")
      assert page.has_link?("Logout")
    end
  end

  test 'logging out' do
    VCR.use_cassette('user-profile') do
      visit "/"
      click_link "Login with Github"

      assert_equal "/robbielane", current_path

      click_link "Logout"

      assert_equal "/", current_path
    end
  end
end
