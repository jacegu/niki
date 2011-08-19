require 'minitest/autorun'
require 'server'

module Kernel
  def feature(feature_name, &feature_spec)
    describe feature_name do
      before{ run_niki_server }
      after{ stop_niki_server }
      instance_eval &feature_spec
    end
  end

  def run_niki_server
    @niki = Niki::Niki.new
    @server = Niki::Server.new(@niki, HttpTesting::DEFAULT_PORT)
    Thread.new{ @server.start }
  end

  def stop_niki_server
    @server.stop
  end
end
