
require "securerandom"

module Utils
  
  def generate_sid
    if self.sid.nil? or self.sid==""
      self.sid = SecureRandom.uuid
    end
  end

end