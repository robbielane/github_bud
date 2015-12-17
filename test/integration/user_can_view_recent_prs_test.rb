require 'test_helper'

class UserCanSeePrsTest < ActionDispatch::IntegrationTest
  test 'recent commits displayed on profile' do
    VCR.use_cassette('user-profile') do
      visit '/'
      click_link 'Login with Github'

      within '.recent-pull-requests' do
        assert page.has_content?('robbielane:7-view-organizations-user-is-a-member-of	Dec 16, 2015 - 10:17:39 PM	add orgs to sidebar	')
      end
    end
  end
end
