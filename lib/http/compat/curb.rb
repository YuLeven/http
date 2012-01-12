require 'http'

# Compatibility with the Curb gem
module Curl
  class Easy
    attr_accessor :headers, :encoding
    attr_reader   :response_code, :body_str

    def self.http_post(url, request_body = nil)
      Easy.new(url).tap { |e| e.http_post(request_body) }
    end

    def self.http_get(url, request_body = nil)
      Easy.new(url).tap { |e| e.http_get(request_body) }
    end

    def initialize(url, method = nil, request_body = nil, headers = {})
      @url = url
      @method = method
      @request_body = request_body
      @headers = headers
      @response_code = @body_str = nil

      @client = Http::Client.new @url, :headers => @headers
    end

    def perform
      response = @client.send @method
      @response_code, @body_str = response.code, response.body
      true
    end

    def http_get(request_body = nil)
      @method, @request_body = :get, request_body
      perform
    end

    def http_put(request_body = nil)
      @method, @request_body = :put, request_body
      perform
    end

     def http_post(request_body = nil)
      @method, @request_body = :post, request_body
      perform
    end

    def http_delete
      @method = :delete
      perform
    end
  end
end
