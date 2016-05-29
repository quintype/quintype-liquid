module Quintype
  module Liquid
    class Railtie < Rails::Engine
      initializer "quintype-liquid.assets.precompile" do |app|
        app.config.assets.paths << root.join("assets", "javascripts").to_s
        app.config.assets.paths << root.join("vendor", "assets", "javascripts").to_s
      end
      
      initializer "quintype-liquid.liquid-file-system" do |app|
        template_path = ::Rails.root.join('app/views')
        ::Liquid::Template.file_system = Quintype::Liquid::FileSystem.new(template_path)
      end

      initializer "quintype-liquid.fix-caching" do |app|
        ::Liquid::Rails::TemplateHandler.send(:prepend, Quintype::Liquid::LiquidTemplateCachingModule) unless Rails.env.development?
      end
    end
  end
end
