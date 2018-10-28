# -*- encoding: utf-8 -*-
# stub: transitions 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "transitions".freeze
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Timo R\u00F6\u00DFner".freeze]
  s.date = "2016-02-05"
  s.description = "Lightweight state machine extracted from ActiveModel".freeze
  s.email = ["timo.roessner@googlemail.com".freeze]
  s.homepage = "http://github.com/troessner/transitions".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.7".freeze
  s.summary = "State machine extracted from ActiveModel".freeze

  s.installed_by_version = "2.7.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<test-unit>.freeze, ["~> 2.5"])
      s.add_development_dependency(%q<mocha>.freeze, ["~> 0.11.0"])
      s.add_development_dependency(%q<random_data>.freeze, [">= 0"])
      s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
      s.add_development_dependency(%q<activerecord>.freeze, ["<= 4.0", ">= 3.0"])
      s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.36"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<test-unit>.freeze, ["~> 2.5"])
      s.add_dependency(%q<mocha>.freeze, ["~> 0.11.0"])
      s.add_dependency(%q<random_data>.freeze, [">= 0"])
      s.add_dependency(%q<appraisal>.freeze, [">= 0"])
      s.add_dependency(%q<activerecord>.freeze, ["<= 4.0", ">= 3.0"])
      s.add_dependency(%q<rubocop>.freeze, ["~> 0.36"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<test-unit>.freeze, ["~> 2.5"])
    s.add_dependency(%q<mocha>.freeze, ["~> 0.11.0"])
    s.add_dependency(%q<random_data>.freeze, [">= 0"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_dependency(%q<activerecord>.freeze, ["<= 4.0", ">= 3.0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.36"])
  end
end
