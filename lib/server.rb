require 'webrick'
require 'erb'
require 'niki'

class Server
  include WEBrick

  PUBLIC_DIR = 'public'

  def initialize(niki, port = 8583)
    @server = WEBrick::HTTPServer.new(:Port => port, :DocumentRoot => PUBLIC_DIR)
    @server.mount('/niki', NikiServlet, niki)
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

  class NikiServlet < HTTPServlet::AbstractServlet
    def do_GET(request, response)
      @niki = @options[0]
      response.body = render :index
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
        niki.add_page page
      end
    end
  end
end
