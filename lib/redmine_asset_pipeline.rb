require "redmine_asset_pipeline/version"

module RedmineAssetPipeline
  # Run the classic redmine plugin initializer after rails boot
  class Plugin < ::Rails::Engine
    config.after_initialize do
      require File.expand_path("../../init", __FILE__)
    end
  end
end
