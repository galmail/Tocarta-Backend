require_dependency 'onceocho'

Onceocho.configure do |c|
  c.logger = Logger.new(STDOUT)
  # c.logger = Rails.logger
  c.app_key = '326e4474f37a5cd5f732c443d16c227f'
  c.secret_key = '37bf929203d46674a158410c83144858'
end
