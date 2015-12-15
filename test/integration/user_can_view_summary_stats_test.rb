class UserCanViewSummaryStatsTest < ActionDispatch::IntegrationTest
  test 'user can see contribution info' do
    VCR.use_cassette("user-stats") do
      visit '/'
      click_link 'Login with Github'
      within ".contribution" do
        assert page.has_content?('477')
        assert page.has_content?('Contributions in last year')
      end

      within ".longest-streak" do
        assert page.has_content?('16')
      end

      within ".current-streak" do
        assert page.has_content?('2')
      end
    end
  end
end
