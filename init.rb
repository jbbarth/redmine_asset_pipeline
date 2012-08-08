app = RedmineApp::Application
unless app.config.assets.enabled
  app.configure do
    config.assets.enabled = true
    config.assets.prefix = ""
    config.assets.debug = false
    config.assets.compile = true
    config.assets.paths << "#{config.root}/public"
    config.assets.paths << "#{config.root}/public/stylesheets"
    config.assets.paths << "#{config.root}/public/javascripts"
    config.assets.paths << "#{config.root}/public/images"
    config.assets.paths += Dir.glob("#{config.root}/plugins/*/assets")
  end
  Sprockets::Railtie.run_initializers(nil, app)
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
