require "bundler"
Bundler.setup

require "rspec"
require "rspec/core/rake_task"
Rspec::Core::RakeTask.new(:spec)

gemspec = eval(File.read("validated_fields.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["validated_fields.gemspec"] do
  system "gem build validated_fields.gemspec"
  system "gem install validated_fields-#{ValidatedField::VERSION}.gem"
end
