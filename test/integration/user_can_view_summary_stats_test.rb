class UserCanViewSummaryStatsTest < ActionDispatch::IntegrationTest
  test 'user can see contribution info' do
    VCR.use_cassette("user-profile") do
      visit '/'
      click_link 'Login with Github'

      within ".contribution" do
        assert page.has_content?('Contributions in the last year')
      end

      within ".longest-streak" do
        assert page.has_content?('Longest Streak')
      end

      within ".current-streak" do
        assert page.has_content?('Current Streak')
      end
    end
  end
end
