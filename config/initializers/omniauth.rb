Rails.application.config.middleware.use OmniAuth::Builder do
  # The following is for facebook
  provider :facebook, Application['fb']['app_id'], Application['fb']['secret_key'], {:scope => 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access'}
end
