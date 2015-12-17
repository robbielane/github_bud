class PullRequest
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def service
    @service = GithubService.new(user)
  end

  def all
    list_repos.map do |repo|
      service.repo_pull_requests(repo).map { |pull| OpenStruct.new(pull) }
    end
    .flatten
  end

  def list_repos
    service.repos.map { |repo| repo[:name] }
  end

  def merge(repo_name, pr_num)
    service.merge_pr(repo_name, pr_num)
  end
end
