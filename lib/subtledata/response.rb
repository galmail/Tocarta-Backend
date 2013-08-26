module Subtledata
  module Response
    def self.create( response, format_out )
      data = response.split('|')

      if data[0] == '0000'
        # If startup method just retun session token
        Subtledata.logger.info "* startup response"
        data[1]
      elsif format_out == 'boolean'
        # Return boolean
        Subtledata.logger.info "* boolean response"
        return true  if data[1] == '1'
        return false if data[1] == '0'
      elsif format_out == 'parse'
        # Parse the reponse
        Subtledata.logger.info "* parsed response"
        parse_output(data)
      else
        Subtledata.logger.info "* general response"
        data
      end
    end

    private

    # Parse the response to a more human format
    # FIXME: This needs to improve
    def self.parse_output(data)
      puts "data=#{data}"
      if !data[1].nil?
        if data[1].match(/~/)
          data[1] = data[1].split('~')
          data[1] = data[1].map { |v| v.split('^') if v.match(/\^/) }
          data[1].each do |i|
            i.map! { |v| v.match(/`/) ? v.split('`') : v }
          end
        elsif data[1].match(/\^/)
          data[1] = data[1].split('^')
          data[1].map! { |v| v.match(/`/) ? v.split('`') : v }
        end
      end
      data
    end

    # attr_reader :pagination
    # attr_reader :meta
  end
end
