module RedmineAssetPipeline
  class SprocketsProcessor < Sprockets::DirectiveProcessor
    # This processor subclasses the standard Sprockets::DirectiveProcessor
    # as advised in Sprockets, to add a new directive called
    # "require_redmine_plugins". This directive is relative to the
    # #{Rails.root}/plugins/ directory and accepts wildcards.
    #
    # For convenience, it also replaces "ALL" by a star ("*") before
    # evaluating the globing. Otherwise, "*/" is interpreted as the end of
    # the comment in CSS files, which is obviously problematic.
    #
    #
    # For the record, here's the example custom require provided in sprockets:
    #
    # def process_require_glob_directive
    #  Dir["#{pathname.dirname}/#{glob}"].sort.each do |filename|
    #    require(filename)
    #  end
    # end

    def process_require_redmine_plugins_directive(mask)
      # make the requested path relative to #{Rails.root}/plugins/
      mask = mask.gsub('ALL', '*')
      mask = Rails.root.join('plugins', mask).expand_path

      Dir.glob(mask).sort.each do |dir|
        require_absolute_tree(dir)
      end
    end

    # Same code as "process_require_tree_directive(path)", without
    # any check of relativity of path
    #
    # TODO: maybe some refactoring
    def require_absolute_tree(directory)
      root = pathname.dirname.join(directory).expand_path

      unless (stats = stat(root)) && stats.directory?
        raise ArgumentError, "require_tree argument must be a directory"
      end

      context.depend_on(root)

      entries(root).each do |pathname|
        pathname = root.join(pathname)
        if pathname.to_s == self.file
          next
        elsif context.asset_requirable?(pathname)
          context.require_asset(pathname)
        end
      end
    end
  end
end
