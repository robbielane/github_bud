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

  def self.language_percents
    percents = {}
    total = languages.map { |_,bytes| bytes }.reduce(0, :+)
    languages.each do |language, bytes|
      percents[language] = ((bytes / total.to_f) * 100).round(1)
    end
    percents
  end
end
