require "redmine_asset_pipeline/version"

module RedmineAssetPipeline
  # Run the classic redmine plugin initializer after rails boot
  class Plugin < ::Rails::Engine
    config.after_initialize do
      require File.expand_path("../../init", __FILE__)
    end

    #asset pipeline configuration
    #enable asset pipeline before sprockets boots
    initializer 'redmine.asset_pipeline', :before => 'sprockets.environment' do
      RedmineApp::Application.configure do
        config.assets.enabled = true
        #config.assets.debug = false
        #config.assets.compile = true
        config.assets.prefix = "" #else we break the standard helpers / standard assets
        #add some paths
        config.assets.paths << "#{config.root}/public/stylesheets"
        config.assets.paths << "#{config.root}/public/javascripts"
        config.assets.paths << "#{config.root}/public/images"
        config.assets.paths << "#{config.root}/public/themes"
      end
    end

    #add all plugin directories in case some js/css/images are included directly or via relative css
    #it also avoids Sprocket's FileOutsidePaths errors
    # config.assets.paths += Dir.glob("#{config.root}/plugins/*/assets")
    #add our directory
    # config.assets.paths += Dir.glob("#{File.dirname(__FILE__)}/assets")
    #compression
    # config.assets.compress = true
    # config.assets.css_compressor = :yui
    # config.assets.js_compressor = :yui

    # Register our processor (subclass of the standard one which adds a directive for redmine plugins)
    initializer 'redmine.sprockets_processor', :after => 'sprockets.environment' do
      require 'redmine_asset_pipeline/sprockets_processor'
      env = RedmineApp::Application.assets
      env.unregister_preprocessor('text/css', Sprockets::DirectiveProcessor)
      env.unregister_preprocessor('application/javascript', Sprockets::DirectiveProcessor)
      env.register_preprocessor('text/css', RedmineAssetPipeline::SprocketsProcessor)
      env.register_preprocessor('application/javascript', RedmineAssetPipeline::SprocketsProcessor)
    end

    # Patch redmine's js/css helpers so they work with sprockets
    config.to_prepare do
      require_dependency 'redmine_asset_pipeline/application_helper_patch'
    end
  end
end
