require 'test_helper'

class UserCanViewSidebarTest < ActionDispatch::IntegrationTest
  test 'it shows the user details' do
    VCR.use_cassette('user-profile') do
      visit '/'
      click_link 'Login with Github'

      assert page.has_css?("img[src*='https://avatars.githubusercontent.com/u/12688159?v=3']")

      within ".followers" do
        assert page.has_content?('8')
      end

      within ".starred" do
        assert page.has_content?('1')
      end

      within ".following" do
        assert page.has_content?('1')
      end

      within ".orgs" do
        assert page.has_css?("img[src*='https://avatars.githubusercontent.com/u/16327293?v=3']")
      end
    end
  end
end
