require 'webrick'
require 'niki/wiki'
require 'niki/page_request'
require 'niki/servlets/all'

module Niki
  class Server
    include WEBrick
    include Servlets

    PUBLIC_DIR = 'public'

    def initialize(wiki, port = 8583)
      @server = WEBrick::HTTPServer.new(:Port => port, :DocumentRoot => PUBLIC_DIR)

      @server.mount '/new-page', NewPageServlet,      wiki
      @server.mount '/pages',    ExistingPageServlet, wiki

      trap('INT'){ stop }
    end

    def start
      @server.start
    end

    def stop
      @server.shutdown
    end
  end
end
