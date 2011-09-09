require 'erb'

module Niki
  module Servlets
    module Renderer
      VIEWS_DIR  = 'views'

      def render(view)
        html = ""
        File.open("#{VIEWS_DIR}/#{view}.html.erb", 'r'){ |f| html = f.read }
        ERB.new(html).result(binding)
      end
    end
  end
end
