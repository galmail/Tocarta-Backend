require 'faraday_middleware'

module Onceocho
  module Connection
    private

    def connection(raw=false)
      options = {
        # :headers => {'Accept' => "application/#{format}; charset=utf-8", 'User-Agent' => user_agent},
        # :proxy => proxy,
        # :ssl => {:verify => false},
        :url => url
      }

      Faraday::Connection.new(options) do |connection|
        conn.request :oauth, 'TOKEN'
        conn.request :json

        conn.response :xml,  :content_type => /\bxml$/
        conn.response :json, :content_type => /\bjson$/

        connection.use :instrumentation
        connection.adapter(adapter)
      end
    end
  end
end
