class UserCanViewSummaryStatsTest < ActionDispatch::IntegrationTest
  test 'user can see contribution info' do
    VCR.use_cassette("user-stats") do
      visit '/'
      click_link 'Login with Github'

      within ".contribution" do
        assert page.has_content?('477 total')
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
