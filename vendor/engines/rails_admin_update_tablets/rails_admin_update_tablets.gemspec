$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_admin_update_tablets/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_admin_update_tablets"
  s.version     = RailsAdminUpdateTablets::VERSION
  s.authors     = ["TODO: Gal Dubitski"]
  s.email       = ["TODO: gal@tocarta.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of RailsAdminUpdateTablets."
  s.description = "TODO: Description of RailsAdminUpdateTablets."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.12"
end
