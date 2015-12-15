require 'test_helper'

class UserCanLoginViaGithubTest < ActionDispatch::IntegrationTest
  def setup
    stub_omniauth
  end

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

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: "github",
      uid: "12688159",
      extra: {
        raw_info: {
          name: "Robbie Lane",
          login: "robbielane",
        }
      },
      credentials: {
        token: ENV["SAMPLE_OAUTH_TOKEN"],
        secret: "secretpizza"
      }
    })
  end
end
