module ReposHelper
  def generate_language_graph(data)
    slices = []
    offset = 0
    data.language_percents.each do |key, percent|
      slices << raw("<circle r='25%' cx='50%' cy='50%' class=" + "'#{key}'" + " style=" + "'stroke-dasharray: #{percent} 100; stroke-dashoffset: -#{offset}'" + "></circle>")
      offset += percent
    end
    slices
  end

  def generate_contributors_graph(data)
    slices = []
    offset = 0
    count = 0
    data.contributors_percents.each do |key, percent|
      slices << raw("<circle r='25%' cx='50%' cy='50%' class=" + "'color#{count}'" + " style=" + "'stroke-dasharray: #{percent} 100; stroke-dashoffset: -#{offset}'" + "></circle>")
      offset += percent
      count += 1
    end
    slices
  end
end
