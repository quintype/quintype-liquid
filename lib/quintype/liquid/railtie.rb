module Quintype
  module Liquid
    class Railtie < Rails::Engine
      initializer "quintype-liquid.assets.precompile" do |app|
        app.config.assets.paths << root.join("assets", "javascripts").to_s
        app.config.assets.paths << root.join("vendor", "assets", "javascripts").to_s
      end
    end
  end
end
