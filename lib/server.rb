require 'webrick'

class Server
  include WEBrick

  def initialize(wiki)
    @server = WEBrick::HTTPServer.new(:Port => 8583)
    @server.mount('/', NikiServlet)
    trap('INT'){ @server.shutdown }
  end

  def start
    @server.start
  end

  def stop
    @server.stop
  end

  class NikiServlet < HTTPServlet::AbstractServlet
    def do_GET(request, response)
      response.body = """ <html>
                          <head><title>Niki</title></head>
                          <body>no niki has been created</body>
                          </html> """
    end
  end
end
