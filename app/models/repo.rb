class Repo
  attr_reader :repo, :user

  def initialize(user, repo=nil)
    @user = user
    @repo = repo
  end

  def service
    @service ||= GithubService.new(user)
  end

  def all
    service.repos.map { |repo| OpenStruct.new(repo) }
  end

  def starred
    service.starred_repos.map { |repo| OpenStruct.new(repo) }
  end

  def find
    OpenStruct.new(service.repo(repo))
  end

  def commits
    service.repo_commits(repo).map { |commit| OpenStruct.new(commit) }
  end

  def repo_languages
    service.languages(repo)
  end

  def repo_stats
    @stats ||= service.stats(repo).map { |contrib| OpenStruct.new(contrib)}
  end

  def contributors_percents
    percents = {}
    total = repo_stats.map { |contrib| contrib.total }.reduce(0, :+)
    repo_stats.each do |contrib|
      percents[contrib.author[:login]] = ((contrib.total / total.to_f) * 100).round(1)
    end
    percents
  end

  def language_percents
    percents = {}
    total = repo_languages.map { |_,bytes| bytes }.reduce(0, :+)
    repo_languages.each do |language, bytes|
      percents[language] = (((bytes / total.to_f) * 100) + 0.1).round(1)
    end
    percents
  end
end
