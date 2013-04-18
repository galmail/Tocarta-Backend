module Subtledata
  module Auth
    def get_session_token
      r = get(Subtledata.base, {"0000" => [Subtledata.secret] })
    end
  end
end
