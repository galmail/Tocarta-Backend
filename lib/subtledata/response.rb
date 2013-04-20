module Subtledata
  module Response
    def self.create( response, boolean )
      data = response.split('|')
      if data[0] == '0000'
        Subtledata.logger.info "* startup response"
        return data[1]
      elsif boolean
        Subtledata.logger.info "* boolean response"
        return true  if data[1] == '1'
        return false if data[1] == '0'
      else
        Subtledata.logger.info "* general resonse"
        return data
      end
    end

    # attr_reader :pagination
    # attr_reader :meta
  end
end
