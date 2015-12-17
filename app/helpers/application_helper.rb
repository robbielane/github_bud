module ApplicationHelper
  def embedded_svg filename, options={}
   file = File.read(Rails.root.join('app', 'assets', 'images', filename))
   doc = Nokogiri::HTML::DocumentFragment.parse file
   svg = doc.at_css 'svg'
   if options[:class].present?
     svg['class'] = options[:class]
   end
   doc.to_html.html_safe
 end

  def format_date_time(timestamp)
    DateTime.parse(timestamp).strftime('%b %d, %Y - %r')
  end
end
