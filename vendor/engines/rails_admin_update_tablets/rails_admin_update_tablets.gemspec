$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_admin_update_tablets/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_admin_update_tablets"
  s.version     = RailsAdminUpdateTablets::VERSION
  s.authors     = ["Gal Dubitski"]
  s.email       = ["gal@tocarta.com"]
  s.homepage    = "http://tocarta.es"
  s.summary     = "Summary of RailsAdminUpdateTablets."
  s.description = "Description of RailsAdminUpdateTablets."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.12"
end
