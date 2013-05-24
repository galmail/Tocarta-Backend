# Load config file
Application = YAML.load(ERB.new(File.read("#{Rails.root}/config/application.yml")).result)[Rails.env]
