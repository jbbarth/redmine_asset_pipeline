require 'redmine'
require 'redmine_asset_pipeline/hooks'

ActionDispatch::Callbacks.to_prepare do
  require_dependency 'redmine_asset_pipeline/application_helper_patch'
end

app = RedmineApp::Application
unless app.config.assets.enabled
  # Configure asset pipeline for our needs
  app.configure do
    config.assets.enabled = true
    config.assets.prefix = ""
    config.assets.debug = false
    config.assets.compile = true
    config.assets.paths << "#{config.root}/public"
    config.assets.paths << "#{config.root}/public/stylesheets"
    config.assets.paths << "#{config.root}/public/javascripts"
    config.assets.paths << "#{config.root}/public/images"
    config.assets.paths << "#{config.root}/public/themes"
    #avoid Sprocket's FileOutsidePaths errors:
    config.assets.paths << "#{config.root}/plugins"
    #if we want to add all plugin directories:
    #config.assets.paths += Dir.glob("#{config.root}/plugins/*/assets")
    #or juste the 'all_plugins' templates, with everything concatenated/minified inside:
    config.assets.paths << File.expand_path('../assets', __FILE__)
  end
  # Manually initialize Sprockets
  Sprockets::Railtie.run_initializers(nil, app)

  # Register our processor (subclass of the standard one which adds a directive for redmine plugins)
  require 'redmine_asset_pipeline/sprockets_processor'
  env = app.assets
  env.unregister_preprocessor('text/css', Sprockets::DirectiveProcessor)
  env.unregister_preprocessor('application/javascript', Sprockets::DirectiveProcessor)
  env.register_preprocessor('text/css', RedmineAssetPipeline::SprocketsProcessor)
  env.register_preprocessor('application/javascript', RedmineAssetPipeline::SprocketsProcessor)
end

Redmine::Plugin.register :redmine_asset_pipeline do
  name 'Redmine Asset Pipeline plugin'
  description 'This plugin adds asset pipeline support for redmine and redmine plugins'
  author 'Jean-Baptiste BARTH'
  author_url 'mailto:jeanbaptiste.barth@gmail.com'
  url 'https://github.com/jbbarth/redmine_asset_pipeline'
  version '0.0.1'
  requires_redmine :version_or_higher => '2.0.0'
end
