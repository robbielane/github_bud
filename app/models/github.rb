class Github
  attr_reader :user

  def initialize(user)
    @user = user
    @github = Hurley::Client.new("https://api.github.com")
    @github.header[:accept] = "application/vnd.github+json"
    @github.query[:access_token] = user.oauth_token
  end

  def repos
    JSON.parse(@github.get("users/#{user.nickname}/repos").body)
  end

  def user_info
    JSON.parse(@github.get("users/#{user.nickname}").body)
  end
end
