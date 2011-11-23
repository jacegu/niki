require 'erb'

module Niki
  module Servlets
    module Renderer
      VIEWS_DIR  = 'views'

      def render(view)
        view_file = "#{VIEWS_DIR}/#{view}.html.erb"
        ERB.new(content_of(view_file)).result(binding)
      end

      def content_of(file)
        File.open(file, 'r'){ |f| f.read }
      end
    end
  end
end
