# -*- encoding: utf-8 -*-
# stub: fancybox-rails 0.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "fancybox-rails".freeze
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Chris Mytton".freeze, "Les Hill".freeze, "Dennis Reimann".freeze, "Mattias Svedhem".freeze, "Greg Reinacker".freeze]
  s.date = "2015-11-19"
  s.description = "This gem provides jQuery FancyBox for your Rails application.".freeze
  s.email = ["chrismytton@gmail.com".freeze]
  s.homepage = "https://github.com/chrismytton/fancybox-rails".freeze
  s.rubygems_version = "2.7.7".freeze
  s.summary = "Use FancyBox with the Rails asset pipeline".freeze

  s.installed_by_version = "2.7.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>.freeze, [">= 3.1.0"])
    else
      s.add_dependency(%q<railties>.freeze, [">= 3.1.0"])
    end
  else
    s.add_dependency(%q<railties>.freeze, [">= 3.1.0"])
  end
end
