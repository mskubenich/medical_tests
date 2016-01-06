# -*- encoding: utf-8 -*-
# stub: minitest-matchers 1.4.1 ruby lib

Gem::Specification.new do |s|
  s.name = "minitest-matchers"
  s.version = "1.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Wojciech Mach", "Ryan Davis"]
  s.date = "2013-10-08"
  s.description = "Adds support for RSpec-style matchers"
  s.email = ["wojtek@wojtekmach.pl", "ryand-ruby@zenspider.com"]
  s.homepage = ""
  s.rubyforge_project = "minitest-matchers"
  s.rubygems_version = "2.5.1"
  s.summary = "Adds support for RSpec-style matchers"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<minitest>, ["~> 5.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<minitest>, ["~> 5.0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<minitest>, ["~> 5.0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
