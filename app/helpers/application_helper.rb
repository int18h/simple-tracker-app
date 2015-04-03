module ApplicationHelper
  def page_header(title, text = nil, path = nil)
    back = nil
    if !path.nil?
      back = link_to 'Back', path, :class => 'btn btn-link'
    end
    provide(:title, title)
    "<h1 class='page-header'>#{text} #{back}</h1>".html_safe
  end  
end
