# -*- encoding: utf-8 -*-
# stub: sidekiq 2.17.8 ruby lib

Gem::Specification.new do |s|
  s.name = "sidekiq".freeze
  s.version = "2.17.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Mike Perham".freeze]
  s.date = "2014-09-11"
  s.description = "Simple, efficient background processing for Ruby".freeze
  s.email = ["mperham@gmail.com".freeze]
  s.executables = ["sidekiq".freeze, "sidekiqctl".freeze]
  s.files = ["bin/sidekiq".freeze, "bin/sidekiqctl".freeze]
  s.homepage = "http://sidekiq.org".freeze
  s.licenses = ["LGPL-3.0".freeze]
  s.rubygems_version = "2.5.2.3".freeze
  s.summary = "Simple, efficient background processing for Ruby".freeze

  s.installed_by_version = "2.5.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<redis>.freeze, ["~> 3.1"])
      s.add_runtime_dependency(%q<redis-namespace>.freeze, ["~> 1.3"])
      s.add_runtime_dependency(%q<connection_pool>.freeze, ["~> 2.0"])
      s.add_runtime_dependency(%q<celluloid>.freeze, ["= 0.15.2"])
      s.add_runtime_dependency(%q<json>.freeze, [">= 0"])
      s.add_development_dependency(%q<sinatra>.freeze, [">= 0"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 4.2"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rails>.freeze, ["= 4.0.5"])
      s.add_development_dependency(%q<coveralls>.freeze, [">= 0"])
    else
      s.add_dependency(%q<redis>.freeze, ["~> 3.1"])
      s.add_dependency(%q<redis-namespace>.freeze, ["~> 1.3"])
      s.add_dependency(%q<connection_pool>.freeze, ["~> 2.0"])
      s.add_dependency(%q<celluloid>.freeze, ["= 0.15.2"])
      s.add_dependency(%q<json>.freeze, [">= 0"])
      s.add_dependency(%q<sinatra>.freeze, [">= 0"])
      s.add_dependency(%q<minitest>.freeze, ["~> 4.2"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rails>.freeze, ["= 4.0.5"])
      s.add_dependency(%q<coveralls>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<redis>.freeze, ["~> 3.1"])
    s.add_dependency(%q<redis-namespace>.freeze, ["~> 1.3"])
    s.add_dependency(%q<connection_pool>.freeze, ["~> 2.0"])
    s.add_dependency(%q<celluloid>.freeze, ["= 0.15.2"])
    s.add_dependency(%q<json>.freeze, [">= 0"])
    s.add_dependency(%q<sinatra>.freeze, [">= 0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 4.2"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rails>.freeze, ["= 4.0.5"])
    s.add_dependency(%q<coveralls>.freeze, [">= 0"])
  end
end
