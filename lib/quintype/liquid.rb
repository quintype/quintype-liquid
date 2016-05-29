require "quintype/liquid/version"

require "liquid-rails"
require "concurrent"

module Quintype
  module Liquid
    autoload :Templates,                    "quintype/liquid/templates"
    autoload :LiquidTemplateCachingModule,  "quintype/liquid/liquid_template_caching_module"
    autoload :FileSystem,                   "quintype/liquid/file_system"
  end
end

require "quintype/liquid/railtie" if defined?(Rails)
