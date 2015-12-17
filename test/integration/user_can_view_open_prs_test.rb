require 'test_helper'

class UserCanViewOpenPrsTest < ActionDispatch::IntegrationTest
  test 'pull requests page' do
    VCR.use_cassette('pull-requests') do
      visit '/'
      click_link 'Login with Github'
      click_link 'Pull Requests'

      within '.pull-requests' do
        assert page.has_content?('github_bud	14 view pull requests [WIP]	Add recent PRs to profile')
        click_link 'Merge'
      end

      assert page.has_content? "Sorry, something went wrong" # ;)
    end
  end
end
