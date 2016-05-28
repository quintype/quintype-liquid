module Quintype
  module Liquid
    class Templates
      attr_reader :paths
    
      def initialize
        @root = Rails.root.join("app", "views").to_s
        @paths = Dir.glob("#{@root}/**/*.liquid").sort
      end
    
      def templates
        paths.reduce({}) do |acc, path|
          acc[clean_path(path)] = IO.read path
          acc
        end
      end
    
      private
    
      def clean_path(path)
        path
          .sub(@root, '')
          .sub('.liquid', '')
          .sub(/^\//, '')
      end
    end
  end
end
