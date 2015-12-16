class UserCanViewSummaryStatsTest < ActionDispatch::IntegrationTest
  test 'user can see contribution info' do
    VCR.use_cassette("user-stats") do
      visit '/'
      click_link 'Login with Github'
      Contributions.any_instance.stubs(:current).returns(["Dec 14, 2015 - Dec 15, 2015", 2])
      Contributions.any_instance.stubs(:longest).returns(["Nov 05, 2015 - Nov 20, 2015", 16])
      Contributions.any_instance.stubs(:year_total).returns(["Dec 16, 2014 - Dec 16, 2015", 485])

      within ".contribution" do
        assert page.has_content?('485 total')
      end

      within ".longest-streak" do
        assert page.has_content?('16 days')
      end

      within ".current-streak" do
        assert page.has_content?('2 days')
      end
    end
  end
end
