Rails.application.config.middleware.use OmniAuth::Builder do
  # The following is for facebook
  provider :facebook, ENV['FB_APP_ID'], ENV['FB_SECRET_KEY'], {:scope => 'email, read_stream, read_friendlists, friends_likes, friends_status, offline_access'}
end
