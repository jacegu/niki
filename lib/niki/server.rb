#encoding: utf-8

require 'webrick'
require 'niki/wiki'
require 'niki/servlets/all'

module Niki
  class Server
    include WEBrick
    include Servlets

    PUBLIC_DIR = 'public'

    attr_reader :wiki

    def initialize(wiki, port = 8583)
      @server = WEBrick::HTTPServer.new(:Port => port, :DocumentRoot => PUBLIC_DIR)
      setup_infraestructure_for(wiki)
    end

    def start
      @server.start
    end

    def stop
      @server.shutdown
    end

    def handle(wiki)
      @wiki = wiki
      mount_servlets_to_handle(wiki)
    end

    private

    def setup_infraestructure_for(wiki)
      handle wiki
      trap('INT'){ stop }
    end

    def mount_servlets_to_handle(wiki)
      @server.mount '/new-page', NewPageServlet,      wiki
      @server.mount '/pages',    ExistingPageServlet, wiki
    end
  end
end
