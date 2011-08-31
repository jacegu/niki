require 'webrick'
require 'erb'
require 'niki/wiki'
require 'niki/page_request'

module Niki
  class Server
    include WEBrick

    PUBLIC_DIR = 'public'

    def initialize(niki, port = 8583)
      @server = WEBrick::HTTPServer.new(:Port => port, :DocumentRoot => PUBLIC_DIR)
      @server.mount('/pages', ExistingPageServlet, niki)
      @server.mount('/new-page', NewPageServlet, niki)
      trap('INT'){ stop }
    end

    def start
      @server.start
    end

    def stop
      @server.shutdown
    end

    module Renderer
      VIEWS_DIR  = 'views'

      def render(view)
        html = ""
        File.open("#{VIEWS_DIR}/#{view}.html.erb", 'r'){ |f| html = f.read }
        ERB.new(html).result(binding)
      end
    end

    class HTTPServlet::AbstractServlet
      include Renderer
    end

    class ExistingPageServlet < HTTPServlet::AbstractServlet
      def do_GET(request, response)
        @wiki, @response = @options[0], response
        requested = PageRequest.new(request.path)
        if requested.all_pages?
          render_all_pages
        else
          render_page_with_url(requested.page_url, requested.action)
        end
      end

      def render_all_pages
        @response.body = render :index
      end

      def render_page_with_url(url, action)
        @page = @wiki.page_with_url(url)
        if @page.found?
          render_action_for(@page, action)
        else
          render_not_found
        end
      end

      def render_action_for(page, action)
        case action
        when :edit then @response.body = render :edit_page
        when :show then @response.body = render :page
        else render_not_found
        end
      end

      def render_not_found
        raise WEBrick::HTTPStatus::NotFound
      end

      def do_POST(request, response)
        @wiki, @request, @response = @options[0], request, response
        requested = PageRequest.new(request.path)
        update_page_with_url(requested.page_url)
      end

      def update_page_with_url(url)
        @page = @wiki.page_with_url(url)
        new_title = @request.query['title']
        if new_title.nil? or new_title.strip.empty?
          @error_message = 'every niki must have a title'
          @response.body = render :edit_page
        else
          @page.title = new_title
          @page.content = @request.query['content']
          ExistingPageServlet.redirect_to_page(@page, @response)
        end
      end

      def self.redirect_to_page(page, response)
        page_url = "#{PageRequest::ALL_PAGES_PATH}/#{page.url}"
        response.set_redirect(WEBrick::HTTPStatus::Found, page_url)
      end
    end

    class NewPageServlet < HTTPServlet::AbstractServlet
      def do_GET(request, response)
        response.body = render :new_page
      end

      def do_POST(request, response)
        niki = @options[0]
        @title = request.query['title']
        @content = request.query['content']
        if @title.nil? or @title.empty?
          @error_message = 'every niki must have a title'
          response.body = render :new_page
        else
          page = Page.with(@title, @content)
          niki.add_page(page)
          ExistingPageServlet.redirect_to_page(page, response)
        end
      end
    end

  end
end
