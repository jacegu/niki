#encoding: utf-8

require 'webrick'
require 'niki/wiki'
require 'niki/servlets/all'

module Niki
  class Server
    include WEBrick

    PUBLIC_DIR = 'public'

    def initialize(wiki, port = 8583)
      @server = setup_server_on port
      @server.handle wiki
    end

    def start
      @server.start
    end

    def stop
      @server.shutdown
    end

    def wiki
      @server.wiki
    end

    private

    def setup_server_on(port)
      trap('INT'){ stop }
      WEBrick::HTTPServer.new(Port: port, DocumentRoot: PUBLIC_DIR).extend WikiServer
    end
  end

  module WikiServer
    include Servlets

    attr_reader :wiki

    def handle(wiki)
      @wiki = wiki
      mount_servlets_to_handle(wiki)
    end

    def handle_a_wiki_with(pages)
      handle Wiki.with pages
    end

    private

    def mount_servlets_to_handle(wiki)
       mount '/new-page', NewPageServlet,      wiki
       mount '/pages',    ExistingPageServlet, wiki
    end
  end

end
