module Quintype::Liquid
  module LiquidTemplateCachingModule
    CACHED_TEMPLATES = Concurrent::Map.new do |m, template|
      Rails.logger.info "Compiling Template"
      m[template] = ::Liquid::Template.parse(template)
    end

    def render(template, local_assigns = {})
      @view.controller.headers['Content-Type'] ||= 'text/html; charset=utf-8'

      assigns = if @controller.respond_to?(:liquid_assigns, true)
                  @controller.send(:liquid_assigns)
                else
                  @view.assigns
                end
      assigns['content_for_layout'] = @view.content_for(:layout) if @view.content_for?(:layout)
      assigns.merge!(local_assigns.stringify_keys)

      liquid = LiquidTemplateCachingModule::CACHED_TEMPLATES[template]
      liquid.send(:render!, assigns, filters: filters, registers: { view: @view, controller: @controller, helper: @helper }).html_safe
    end
  end
end
