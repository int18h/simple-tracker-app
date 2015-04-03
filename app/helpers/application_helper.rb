module ApplicationHelper
  def page_header(text, path = nil)
    if !path.nil?
      back = link_to 'Back', path, :class => 'btn btn-link'
    else
      back = ''
    end
    "<h1 class='page-header'>#{text} #{back}</h1>".html_safe
  end  
end
