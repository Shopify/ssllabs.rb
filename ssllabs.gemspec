$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ssllabs/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ssllabs"
  s.version     = Ssllabs::VERSION
  s.authors     = ["Francois Chagnon"]
  s.email       = ["francois.chagnon@shopify.com"]
  s.homepage    = "https://github.com/Shopify/ssllabs.rb/"
  s.summary     = "Ruby API for Qualys SSL Labs scanner."
  s.description = "This is a ruby API to interact with Qualys SSL Labs API. API Documentation is available at https://github.com/ssllabs/ssllabs-scan/blob/master/ssllabs-api-docs.md"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "activesupport", '>= 4.2.0'
  s.add_dependency "json", '~> 2.0'
  s.add_dependency "net", '~> 0.3'
end
