module Subtledata
  module Connection
    private

    # TODO: if raw don't parse output
    def connection(raw=false)
      options = {
        # :headers => {'Accept' => "application/#{format}; charset=utf-8", 'User-Agent' => user_agent},
        # :proxy => proxy,
        :ssl => {:verify => false},
        :url => url
      }

      Faraday::Connection.new(options) do |connection|
        connection.use Faraday::Request::UrlEncoded
        connection.adapter(adapter)
      end
    end
  end
end
