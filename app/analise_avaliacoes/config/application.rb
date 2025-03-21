require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AnaliseAvaliacoes
  class Application < Rails::Application
    config.i18n.default_locale = :'pt-BR'

    Time::DATE_FORMATS[:default] = "%d/%m/%Y %H:%M"
    Date::DATE_FORMATS[:default] = "%d/%m/%Y"
    
    config.generators do |g|
      g.test_framework :rspec
      g.assets         false
      g.helper         false
      g.javascripts    false
      g.stylesheets    false
      g.scaffold_controller :custom_scaffold_controller 
    end
    
    # config.generators do |generate|
    #   generate.test_framework  :rspec,
    #         fixtures: true,
    #         view_specs: false,
    #         helper_specs: false,
    #         routing_specs: false,
    #         controller_specs: false,
    #         request_specs: false
    #    generate.fixture_replacement :factory_girl, dir: "spec/factories"
    # end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
