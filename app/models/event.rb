class Event
  attr_reader :service

  def initialize(user)
    @service ||= GithubService.new(user)
  end

  def recent_events
    @events ||= service.events_data.map { |event| OpenStruct.new(event) }
  end

  def get_payload(id)
    recent_events.map do |event|
      OpenStruct.new(event.payload) if event.id == id
    end
  end

  def recent_pull_requests
    prs = {}
    recent_events.each_with_index do |event|
      if event.type == "PullRequestEvent"
        payload = get_payload(event.id).compact.first
        prs[payload.pull_request[:head][:label]] = {}
        prs[payload.pull_request[:head][:label]][:title] = payload[:pull_request][:title]
        prs[payload.pull_request[:head][:label]][:body] = payload[:pull_request][:body]
        prs[payload.pull_request[:head][:label]][:time] = payload[:pull_request][:created_at]
        prs[payload.pull_request[:head][:label]][:link] = payload[:pull_request][:html_url]
      end
    end
    prs
  end

  def recent_commits
    repo_commits = {}
    recent_events.each_with_index do |event, i|
      if event.type == "PushEvent"
        payload = get_payload(event.id).compact.first
        payload.commits.each_with_index do |commit, ii|
          time = DateTime.parse(event.created_at).strftime('%b %d, %Y - %r')
          repo_commits["#{i}-#{ii}"] = {}
          repo_commits["#{i}-#{ii}"][:repo] = event.repo[:name]
          repo_commits["#{i}-#{ii}"][:sha] = commit[:sha]
          repo_commits["#{i}-#{ii}"][:message] = commit[:message]
          repo_commits["#{i}-#{ii}"][:time] = time
        end
      end
    end
    repo_commits
  end
end
