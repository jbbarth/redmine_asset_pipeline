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

  # Override core helper so that it doesn't include prototype,effects,dragdrop,controls,rails,application
  def javascript_heads
    #javascripts/ is mandatory here, otherwise /all_core.js
    #is called, which doesn't route anywhere
    tags = javascript_include_tag('javascripts/all_core')
    unless User.current.pref.warn_on_leaving_unsaved == '0'
      tags << "\n".html_safe + javascript_tag("Event.observe(window, 'load', function(){ new WarnLeavingUnsaved('#{escape_javascript( l(:text_warn_on_leaving_unsaved) )}'); });")
    end
    tags
  end

end
