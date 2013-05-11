Redmine Asset Pipeline plugin
=============================

This plugin adds asset pipeline awesomeness to Redmine and Redmine plugins.

For who ?
---------
This plugin only targets plugin developers. You shouldn't try to install this without a deep understanding of the benefits and the way to make it work.

Why ?
-----
By default, Redmine made the deliberate (and wise) choice to disable the asset pipeline for core development. Enabling the asset pipeline by default would bring a thousand questions for people who are not in Rails and have a deep understanding of how it works. See [some of my thoughs about this here](http://www.redmine.org/issues/11445#note-9).

Having the asset pipeline enabled would be interesting though if you have a lot of plugins, which is my case. The average page on my biggest Redmine instance downloads ~50 js/css individual files, which is a big waste in terms of performance and bandwith. I'd really like them to be minified and bundled into one application.js and one application.css.

How ?
-----
The plugin reconfigures asset-related options in the main app.

Features of this plugin
-----------------------
* serve main app assets with the asset pipeline : disabled
* serve plugin assets with the asset pipeline : disabled for standard plugins ; enabled for redmine gems
* minify assets in the pipeline : disabled
* concatenate all plugin assets into one js + one css : ok for redmine gems
* concatenate core resources with the ones of plugins : abandonned (useless)
* compile coffeescript/sass/etc. : not tested yet

Known problems
--------------
* for now it seems that all_plugins.js loads everything already loaded in all_core.js, resulting in unecessary wasted bandwith.

Installation
------------

This plugin is only compatible with Redmine 2.1.0+. It is distributed as a ruby gem.

Add this line to your redmine's Gemfile.local:

    gem 'redmine_asset_pipeline'

And then execute:

    $ bundle install

Then restart your Redmine instance.

Note that general instructions for plugins [here](http://www.redmine.org/wiki/redmine/Plugins) don't apply here.

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
