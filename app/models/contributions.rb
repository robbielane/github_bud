class Contributions
  attr_reader :stats

  def initialize(user)
    @user = user
    @stats ||= GithubStats.new(user.nickname)
  end

  def current
    return ["no streak", 0] if stats.streak.empty?
    dates = "#{format_date(stats.streak.first.date)}" + " - " + "#{format_date(stats.streak.last.date)}"
    [dates, stats.streak.count]
  end

  def longest
    return ["no streak", 0] if stats.longest_streak.empty?
    dates = "#{format_date(stats.longest_streak.first.date)}" + " - " + "#{format_date(stats.longest_streak.last.date)}"
    [dates, stats.longest_streak.count]
  end

  def year_total
    year_stats = stats.data.raw.map { |day| day.score }.reduce(0, :+)
    dates = "#{format_date(stats.data.raw.first.date)}" + " - " + "#{format_date(stats.data.raw.last.date)}"
    [dates, year_stats]
  end

  private

  def format_date(date)
    date.strftime("%b %d, %Y")
  end
end
