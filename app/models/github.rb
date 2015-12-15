class Github
  attr_reader :user

  def initialize(user)
    @user = user
    @stats = GithubStats.new(user.nickname)
  end


end
