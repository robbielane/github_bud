require 'test_helper'

class UserCanViewRepoDetailsTest < ActionDispatch::IntegrationTest
  test 'profile links to repo details page' do
    VCR.use_cassette('repo') do
      visit '/'
      click_link 'Login with Github'
      click_link 'ticketly'

      assert page.has_content?('ticketly')
      within '#commits' do
        assert page.has_content?('Dec 10, 2015 - 06:40:25 PM	eb015d7	robbielane	Merge pull request #94 from robbielane/v')
        assert page.has_content?('Dec 10, 2015 - 06:40:04 PM	d714669	joshuajhun	fixed some css issues with the greeting')
        assert page.has_content?('Dec 10, 2015 - 06:37:11 PM	303d5d1	joshuajhun	changed video resolution. it is down to')
      end

      within '#language_percents' do
        assert page.has_content?('JavaScript - 62.1%')
        assert page.has_content?('CSS - 30.4%')
        assert page.has_content?('Ruby - 5.6%')
        assert page.has_content?('HTML - 2.0%')
        assert page.has_content?('Python - 0.3%')
      end

      within '#contributors' do
        assert page.has_content?('NicoleHall - 2.9%')
        assert page.has_content?('joshuajhun - 9.1%')
        assert page.has_content?('robbielane - 12.5%')
        assert page.has_content?('adamki - 12.8%')
        assert page.has_content?('toriejw - 28.8%')
        assert page.has_content?('acareaga - 33.9%')
      end
    end
  end
end
