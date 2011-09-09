require 'niki/servlets/renderer'

module Niki
  module Servlets
    include WEBrick

    class HTTPServlet::AbstractServlet
      include Renderer

      def render_not_found
        raise WEBrick::HTTPStatus::NotFound
      end

      def redirect_to_page(page, response)
        page_url = "#{PageRequest::ALL_PAGES_PATH}/#{page.url}"
        response.set_redirect(WEBrick::HTTPStatus::Found, page_url)
      end
    end
  end
end

require 'niki/servlets/new_page_servlet'
require 'niki/servlets/existing_page_servlet'
