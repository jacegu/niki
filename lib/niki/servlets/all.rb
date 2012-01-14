require 'niki/servlets/renderer'

module Niki
  module Servlets
    include WEBrick

    class HTTPServlet::AbstractServlet
      include Renderer

      def render_not_found
        raise WEBrick::HTTPStatus::NotFound
      end

      def redirect_to(page, response)
        response.set_redirect(WEBrick::HTTPStatus::Found, full_url_to_page(page))
      end

      def full_url_to_page(page)
        "#{PageRequest::ALL_PAGES_PATH}/#{page.url}"
      end
    end
  end
end

require 'niki/servlets/new_page_servlet'
require 'niki/servlets/existing_page_servlet'
