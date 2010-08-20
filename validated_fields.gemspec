require File.expand_path("../lib/validated_fields/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "validated_fields"
  s.version     = ValidatedFields::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Piotr Chmolowski"]
  s.email       = ["piotr@chmolowski.pl"]
  s.homepage    = "http://github.com/pch/validated-field"
  s.summary     = "View helpers for generating unobtrusive frontend validations based on Rails 3 validators"
  s.description = "Soon to come"

  s.required_rubygems_version = ">= 1.3.6"
  
  #s.rubyforge_project         = "validated_fields"

  # If you have other dependencies, add them here
  # s.add_dependency "another", "~> 1.2"

  # If you need to check in files that aren't .rb files, add them here
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.require_path = 'lib'
end