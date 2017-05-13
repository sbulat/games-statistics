module ApplicationHelper
  def icon_span(icon)
    "<span class='glyphicon glyphicon-#{icon}'></span>".html_safe
  end
end
