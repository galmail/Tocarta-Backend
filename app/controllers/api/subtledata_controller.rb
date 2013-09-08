class Api::SubtledataController < AccessController
  before_filter :identify_device, :setup_language

  def get_session_token
    @result =  Subtledata.get_session_token
  end

  def init_client
    @result = Subtledata.client({session_token: Subtledata.get_session_token})
  end
end
