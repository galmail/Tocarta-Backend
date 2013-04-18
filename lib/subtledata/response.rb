module Subtledata
  module Response
    def self.create( response )
      data = response.split('|')
      if data[0] = '0000'
        data[1]
      else
        data
      end
    end

    # attr_reader :pagination
    # attr_reader :meta
  end
end
