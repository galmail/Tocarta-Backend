module Subtledata
  # Manage authentication to SubtleData
  module Auth
    # Get SubtleData session token, necessary for any petition
    def get_session_token
      r = get(@base, {"0000" => [Subtledata.secret] })
    end
  end
end
