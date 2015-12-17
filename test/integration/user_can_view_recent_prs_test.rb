require 'test_helper'

class UserCanSeePrsTest < ActionDispatch::IntegrationTest
  test 'recent commits displayed on profile' do
    VCR.use_cassette('user-profile') do
      visit '/'
      click_link 'Login with Github'

      within '.recent-pull-requests' do
        assert page.has_content?('robbielane:sad-paths	Dec 17, 2015 - 06:22:48 AM	add logout test	-make graph generators')
      end
    end
  end
end
