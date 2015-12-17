class GithubService
  attr_reader :user, :connection

  def initialize(user)
    @user = user
    @connection = Hurley::Client.new("https://api.github.com")
    @connection.header[:accept] = "application/vnd.github+json"
    @connection.query[:access_token] = user.oauth_token
  end

  def repos
    parse(connection.get("/users/#{user.nickname}/repos"))
  end

  def repo(repo_name)
    parse(connection.get("/repos/#{user.nickname}/#{repo_name}"))
  end

  def repo_commits(repo_name)
    parse(connection.get("/repos/#{user.nickname}/#{repo_name}/commits"))
  end

  def languages(repo_name)
    parse(connection.get("/repos/#{user.nickname}/#{repo_name}/languages"))
  end

  def stats(repo_name)
    parse(connection.get("/repos/#{user.nickname}/#{repo_name}/stats/contributors"))
  end

  def user_data
    parse(connection.get("/users/#{user.nickname}"))
  end

  def user_orgs
    parse(connection.get("users/#{user.nickname}/orgs"))
  end

  def starred_repos
    parse(connection.get("/users/#{user.nickname}/starred"))
  end

  def events_data
    parse(connection.get("/users/#{user.nickname}/events", {per_page: 10}))
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

end
