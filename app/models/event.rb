class Event
  attr_reader :service

  def initialize(user)
    @service ||= GithubService.new(user)
  end

  def recent_events
    service.events_data.map { |event| OpenStruct.new(event) }
  end

  def get_payload(id)
    recent_events.map do |event|
      OpenStruct.new(event.payload) if event.id == id
    end
  end

  def recent_commits
    repo_commits = {}
    recent_events.each_with_index do |event, i|
      if event.type == "PushEvent"
        payload = get_payload(event.id).compact.first
        repo_commits[event.repo[:name] + "#{i}"] = payload.commits
      end
    end
    repo_commits
  end
end
