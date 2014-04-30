require 'bigdecimal'
require 'stringio'
require "excon"

module Ganeti



  class Client
    attr_reader   :ganeti_endpoint

    ganeti_endpoint = "https://192.168.2.3:5080"

    
    def initialize(secret=nil, endpoint=nil, options={})
      @options = {}
      endpoint ||= ganeti_endpoint
      
      Excon.defaults[:ssl_ca_file] = File.expand_path(File.join(File.dirname(__FILE__), "../..", "certs", "rapi_pub.pem"))

      if !File.exist?(File.expand_path(File.join(File.dirname(__FILE__), "../..", "certs", "rapi_pub.pem")))
        puts "Certificate file does not exist. SSL_VERIFY_PEER set as false"
        Excon.defaults[:ssl_verify_peer] = false
      else
        Excon.defaults[:ssl_verify_peer] = false
      end
      @con = Excon.new(endpoint)    
      @con
    end

    def get(path)
      @options[:path] = path
      @options[:method] = 'GET'
      res = @con.request(@options)
      res
    end


    def call(path, method)
      begin
        @options[:path] = path
        @options[:method] = method
        res = @con.request(@options)
        res
      rescue Exception => e
        Error.new(e.message)
      end
    end


    def get_version()
      call("system.version")
    end
  end
end
