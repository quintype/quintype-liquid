module Quintype::Liquid
  class FileSystem < ::Liquid::LocalFileSystem
    def caching_enabled?
      Rails.env.production?
    end

    def read_file(path)
      full_path = full_path(path)
      File.read(full_path) if File.exists?(full_path)
    end

    def read_template_file(template_path, context)
      controller = context.registers[:controller]
      controller_path = controller.controller_path
      formats = controller.formats.map { |format| '.' + format.to_s } + ['']

      file = nil

      formats.each do |format|
        path = template_path.include?('/') ? template_path : "#{controller_path}/#{template_path}"
        path = path + format

        file = caching_enabled? ? Rails.cache.fetch(cache_path(path)) { read_file(path) } : read_file(path)

        break if file
      end

      raise Liquid::FileSystemError, "No such template '#{template_path}'" unless file

      file
    end

    def full_path(template_path)
      raise Liquid::FileSystemError, "Illegal template name '#{template_path}'" unless template_path =~ /\A[^.\/][a-zA-Z0-9_\.\/]+\z/

      full_path = if template_path.include?('/'.freeze)
        File.join(root, File.dirname(template_path), @pattern % File.basename(template_path))
      else
        File.join(root, @pattern % template_path)
      end

      raise Liquid::FileSystemError, "Illegal template path '#{File.expand_path(full_path)}'" unless File.expand_path(full_path) =~ /\A#{File.expand_path(root)}/

      full_path
    end

    def cache_path(path)
      "liquid:#{path}"
    end
  end
end
