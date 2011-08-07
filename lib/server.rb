require 'webrick'
require 'niki'

class Server
  include WEBrick

  def initialize(niki, port = 8583)
    @server = WEBrick::HTTPServer.new(:Port => port)
    @server.mount('/', NikiServlet, niki)
    trap('INT'){ sto }
  end

  def start
    @server.start
  end

  def stop
    @server.shutdown
  end

  class NikiServlet < HTTPServlet::AbstractServlet
    def do_GET(request, response)
      niki = @options[0]
      body = 'no niki has been created'
      if niki.has_pages?
        pages = niki.pages.map{ |p| "<li>#{p}</li>" }.join("\n")
        body = "<ul>#{pages}</ul>"
      end
      response.body = """ <html>
                          <head><title>Niki</title></head>
                          <body>
                            #{body}<a href=\"/new-page\">Add a page</a>
                            <a href=\"/new-page\">Add a page</a>
                          </body>
                          </html> """
    end
  end
end
