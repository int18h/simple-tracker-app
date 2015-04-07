module ApplicationHelper
  def page_header(title, text = nil, path = nil)
    back = nil
    if !path.nil?
      back = link_to 'Back', path, :class => 'btn btn-link'
    end
    provide(:title, title)
    "<h1 class='page-header'>#{text} #{back}</h1>".html_safe
  end

  def header(tag, options)
    links = ''
    puts YAML::dump(options[:buttons])
    if !options[:buttons].nil?
      options[:buttons].each do | index, button |
        links = links + (link_to button[:caption], button[:path], :class => button[:class])
      end
    end
    provide(:title, options[:title]) if tag.downcase == 'h1'
    class_name = "page-header" if (tag.downcase == 'h1')
    "<#{tag} class=#{class_name}>#{options[:text]} #{links}</#{tag}>".html_safe
  end  
end
