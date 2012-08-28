require_dependency 'application_helper'

module ApplicationHelper
  def stylesheet_link_tag(*sources)
    return '' if sources.last.is_a?(Hash) && sources.last.delete(:plugin)
    super
  end

  def javascript_include_tag(*sources)
    return '' if sources.last.is_a?(Hash) && sources.last.delete(:plugin)
    super
  end
end
