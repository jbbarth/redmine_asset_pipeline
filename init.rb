require 'redmine'
require 'redmine_asset_pipeline/version'
require 'redmine_asset_pipeline/hooks'

Redmine::Plugin.register :redmine_asset_pipeline do
  name 'Redmine Asset Pipeline plugin'
  description 'This plugin adds asset pipeline support for redmine and redmine plugins'
  author 'Jean-Baptiste BARTH'
  author_url 'mailto:jeanbaptiste.barth@gmail.com'
  url 'https://github.com/jbbarth/redmine_asset_pipeline'
  version RedmineAssetPipeline::VERSION
  requires_redmine :version_or_higher => '2.1.0'
end
