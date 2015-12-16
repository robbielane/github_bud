require 'test_helper'

class UserCanSeeRecentCommitsTest < ActionDispatch::IntegrationTest
  test 'recent commits displayed on profile' do
    VCR.use_cassette('user-profile') do
      visit '/'
      click_link 'Login with Github'

      within '.recent-commits' do
        assert page.has_content?('robbielane/github_bud	Dec 16, 2015 - 10:57:43 PM	b559072	change per_page paramater for events end...')
        assert page.has_content?('robbielane/github_bud	Dec 16, 2015 - 10:53:46 PM	30be6fc	add orgs to sidebar...')
        assert page.has_content?('robbielane/github_bud	Dec 16, 2015 - 10:53:46 PM	e6f000d	Merge pull request #8 from robbielane/7-...')
      end
    end
  end
end
