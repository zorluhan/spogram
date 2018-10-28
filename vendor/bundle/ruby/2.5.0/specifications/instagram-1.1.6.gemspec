# -*- encoding: utf-8 -*-
# stub: instagram 1.1.6 ruby lib

Gem::Specification.new do |s|
  s.name = "instagram".freeze
  s.version = "1.1.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Shayne Sweeney".freeze]
  s.date = "2015-09-02"
  s.description = "A Ruby wrapper for the Instagram REST and Search APIs".freeze
  s.email = ["shayne@instagr.am".freeze]
  s.homepage = "https://github.com/Instagram/instagram-ruby-gem".freeze
  s.post_install_message = "********************************************************************************\n\nInstagram REST and Search APIs\n------------------------------\nOur developer site documents all the Instagram REST and Search APIs.\n(http://instagram.com/developer)\n\nBlog\n----------------------------\nThe Developer Blog features news and important announcements about the Instagram Platform.\nYou will also find tutorials and best practices to help you build great platform integrations.\nMake sure to subscribe to the RSS feed so you don't miss out on new posts:\n(http://developers.instagram.com).\n\nCommunity\n----------------------\nThe Stack Overflow community is a great place to ask API related questions or if you need help with your code.\nMake sure to tag your questions with the Instagram tag to get fast answers from other fellow developers and members of the Instagram team.\n(http://stackoverflow.com/questions/tagged/instagram/)\n\n********************************************************************************\n".freeze
  s.rubyforge_project = "instagram".freeze
  s.rubygems_version = "2.7.7".freeze
  s.summary = "Ruby wrapper for the Instagram API".freeze

  s.installed_by_version = "2.7.7" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, ["~> 0.9.2.2"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 2.4"])
      s.add_development_dependency(%q<webmock>.freeze, ["~> 1.6"])
      s.add_development_dependency(%q<bluecloth>.freeze, ["~> 2.2.0"])
      s.add_runtime_dependency(%q<faraday>.freeze, ["< 0.10", ">= 0.7"])
      s.add_runtime_dependency(%q<faraday_middleware>.freeze, ["< 0.10", ">= 0.8"])
      s.add_runtime_dependency(%q<multi_json>.freeze, [">= 1.0.3", "~> 1.0"])
      s.add_runtime_dependency(%q<hashie>.freeze, [">= 0.4.0"])
    else
      s.add_dependency(%q<rake>.freeze, ["~> 0.9.2.2"])
      s.add_dependency(%q<rspec>.freeze, ["~> 2.4"])
      s.add_dependency(%q<webmock>.freeze, ["~> 1.6"])
      s.add_dependency(%q<bluecloth>.freeze, ["~> 2.2.0"])
      s.add_dependency(%q<faraday>.freeze, ["< 0.10", ">= 0.7"])
      s.add_dependency(%q<faraday_middleware>.freeze, ["< 0.10", ">= 0.8"])
      s.add_dependency(%q<multi_json>.freeze, [">= 1.0.3", "~> 1.0"])
      s.add_dependency(%q<hashie>.freeze, [">= 0.4.0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, ["~> 0.9.2.2"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.4"])
    s.add_dependency(%q<webmock>.freeze, ["~> 1.6"])
    s.add_dependency(%q<bluecloth>.freeze, ["~> 2.2.0"])
    s.add_dependency(%q<faraday>.freeze, ["< 0.10", ">= 0.7"])
    s.add_dependency(%q<faraday_middleware>.freeze, ["< 0.10", ">= 0.8"])
    s.add_dependency(%q<multi_json>.freeze, [">= 1.0.3", "~> 1.0"])
    s.add_dependency(%q<hashie>.freeze, [">= 0.4.0"])
  end
end
