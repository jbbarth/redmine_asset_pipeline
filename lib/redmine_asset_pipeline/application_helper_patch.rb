require_dependency 'application_helper'

module ApplicationHelper
  def stylesheet_link_tag(*sources)
    return '' if sources.last.is_a?(Hash) && sources.last.delete(:plugin)
    #magically find current redmine theme if any defined
    #simplified version of normal version, since the magic is only used in core layout
    if current_theme && current_theme.stylesheets.include?(sources.first)
      super(current_theme.stylesheet_path(sources.first))
    else
      super
    end
  end

  def javascript_include_tag(*sources)
    return '' if sources.last.is_a?(Hash) && sources.last.delete(:plugin)
    super
  end
end
