module Subtledata
  # Defines HTTP request methods
  module Request
    DEFAULT_REQ_OPTS = {raw: false, unformatted: false, no_response_wrapper: false, boolean: false}

    # Perform an HTTP GET request
    def get(path, options={}, request_opts={})
      request(:get, path, options, request_opts)
    end

    # Perform an HTTP POST request
    def post(path, options={}, request_opts={})
      request(:post, path, options, request_opts)
    end

    # Perform an HTTP PUT request
    def put(path, options={}, request_opts={})
      request(:put, path, options, request_opts)
    end

    # Perform an HTTP DELETE request
    def delete(path, options={}, request_opts={})
      request(:delete, path, options, request_opts)
    end

    private

    # Perform an HTTP request
    def request(method, path, options, request_opts)
      request_opts = DEFAULT_REQ_OPTS.merge(request_opts)

      response = connection(request_opts[:raw]).send(method) do |request|
        options = formatted_options(options) unless request_opts[:unformatted]

        case method
        when :get, :delete
          request.url(path, options)
        when :post, :put
          request.path = path
          request.body = options unless options.empty?
        end
      end

      return response if request_opts[:raw]
      return response.body if request_opts[:no_response_wrapper]
      return Response.create( response.body, request_opts[:boolean] )
    end

    def formatted_options(options)
      # FIXME: use inject
      data = {}
      options.each do |k,v|
        data = { "Q" => k + '|' + v.join('|') }
      end
      data
    end
  end
end
