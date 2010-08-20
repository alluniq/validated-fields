require "bundler"
Bundler.setup

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_opts  = %w(-fs --color)
  t.warning    = true
end

gemspec = eval(File.read("validated_fields.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["validated_fields.gemspec"] do
  system "gem build validated_fields.gemspec"
  system "gem install validated_fields-#{ValidatedField::VERSION}.gem"
end


