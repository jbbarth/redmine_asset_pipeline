module RedmineAssetPipeline
  class Hooks < Redmine::Hook::ViewListener
    #adds all plugins css on each page
    def view_layouts_base_html_head(context)
      stylesheet_link_tag("/all_plugins") + javascript_include_tag("/all_plugins")
    end
  end
end
