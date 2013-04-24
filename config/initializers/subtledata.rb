require_dependency 'subtledata'

Subtledata.configure do |c|
  c.logger = Logger.new(STDOUT)
  # c.logger = Rails.logger
  c.secret = 'RzArM1VQ'
end
