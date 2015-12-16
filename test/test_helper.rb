ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/mini_test'
require 'capybara/rails'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'test/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { :serialize_with => :json }
  c.before_record do |r|
    r.request.headers.delete('Authorization')
  end
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end


class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    Capybara.app = GithubApicurious::Application
    stub_omniauth
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: "github",
      uid: "12688159",
      extra: {
        raw_info: {
          name: "Robbie Lane",
          login: "robbielane",
        }
      },
      credentials: {
        token: ENV["SAMPLE_OAUTH_TOKEN"],
        secret: "secretpizza"
      }
    })
  end
end
