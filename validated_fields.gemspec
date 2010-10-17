require File.expand_path("../lib/validated_fields/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "validated_fields"
  s.version     = ValidatedFields::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Piotr Chmolowski"]
  s.email       = ["piotr@chmolowski.pl"]
  s.homepage    = "http://github.com/pch/validated-field"
  s.summary     = "View helpers for unobtrusive frontend validation"
  s.description = "View helpers for generating unobtrusive frontend validators based on Rails 3 validators"

  s.required_rubygems_version = ">= 1.3.6"

  #s.rubyforge_project         = "validated_fields"


  s.add_dependency "actionpack",  "~> 3.0.0"
  s.add_dependency "activemodel", "~> 3.0.0"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec-core", "~> 2.0.0"

  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'
end