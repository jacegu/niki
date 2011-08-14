require 'webrick'
require 'erb'
require 'niki'

class Server
  include WEBrick

  PUBLIC_DIR = 'public'

  def initialize(niki, port = 8583)
    @server = WEBrick::HTTPServer.new(:Port => port, :DocumentRoot => PUBLIC_DIR)
    @server.mount('/', NikiServlet, niki)
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

  class NikiServlet < HTTPServlet::AbstractServlet
    include Renderer

    def do_GET(request, response)
      @niki = @options[0]
      response.body = render :index
    end
  end

  class NewPageServlet < HTTPServlet::AbstractServlet
    def do_GET(request, response)
      response.body = """
                        <html>
                          <head><title>Niki</title></head>
                          <body>
                            <form method='POST' action='/new-page'>
                              <h1>Add a page to niki</h1>
                              <label for='title'>Title</label>
                              <input type='text' name='title' ></input>
                              <label for='content'>Content</label>
                              <textarea name='content' ></textarea>
                              <input type='submit' value='Add page' />
                            </form>
                          </body>
                        </html>
                      """
    end

    def do_POST(request, response)
      niki = @options[0]
      title = request.query['title']
      content = request.query['content']
      page = Page.with(title, content)
      niki.add_page page
    end
  end
end
