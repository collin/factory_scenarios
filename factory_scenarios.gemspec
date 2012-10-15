# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "factory_scenarios"
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Collin Miller"]
  s.date = "2012-10-15"
  s.description = "Build your factory and log-in in a single click. Also see what your emails look like and enter your workflows by clickig on the links in the email"
  s.email = "collintmiller@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt"
  ]
  s.files = [
    ".document",
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "Rakefile",
    "Readme.mdown",
    "VERSION",
    "app/assets/javascripts/factory_scenarios.coffee",
    "app/assets/stylesheets/factory_scenarios.css.sass",
    "app/controllers/factory_scenarios/engine_controller.rb",
    "app/controllers/factory_scenarios/mail_previews_controller.rb",
    "app/controllers/factory_scenarios/scenarios_controller.rb",
    "app/models/factory_scenarios/scenario.rb",
    "app/views/factory_scenarios/mail_previews/index.html.haml",
    "app/views/factory_scenarios/mail_previews/show.html.haml",
    "app/views/factory_scenarios/scenarios/index.html.haml",
    "app/helpers/factory_scenarios/scenarios_helper.rb",
    "config/routes.rb",
    "factory_scenarios.gemspec",
    "lib/factory_scenarios.rb",
    "lib/factory_scenarios/engine.rb",
    "lib/factory_scenarios/mail.rb",
    "lib/factory_scenarios/mail/preview.rb",
    "test/functional/factory_scenarios_controller_test.rb",
    "test/gemfiles/3.1.gemfile",
    "test/gemfiles/3.2.gemfile",
    "test/helper.rb",
    "test/test_factory_scenarios.rb",
    "test/unit/test_scenario.rb"
  ]
  s.homepage = "http://github.com/collin/factory_scenarios"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Use your factories to help you navigate your application state."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.1"])
      s.add_runtime_dependency(%q<dkastner-moneta>, ["~> 0.7"])
      s.add_runtime_dependency(%q<factory_girl>, ["~> 2"])
      s.add_runtime_dependency(%q<warden>, ["~> 1.0"])
      s.add_runtime_dependency(%q<haml>, ["~> 3.0"])
      s.add_runtime_dependency(%q<hashie>, ["~> 1.1"])
      s.add_runtime_dependency(%q<rubyception>, ["~> 0.1.1"])
      s.add_runtime_dependency(%q<jquery-rails>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.1.rc8"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_development_dependency(%q<test_engine>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 3.1"])
      s.add_dependency(%q<dkastner-moneta>, ["~> 0.7"])
      s.add_dependency(%q<factory_girl>, ["~> 2"])
      s.add_dependency(%q<warden>, ["~> 1.0"])
      s.add_dependency(%q<haml>, ["~> 3.0"])
      s.add_dependency(%q<hashie>, ["~> 1.1"])
      s.add_dependency(%q<rubyception>, ["~> 0.1.1"])
      s.add_dependency(%q<jquery-rails>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.1.rc8"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_dependency(%q<test_engine>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.1"])
    s.add_dependency(%q<dkastner-moneta>, ["~> 0.7"])
    s.add_dependency(%q<factory_girl>, ["~> 2"])
    s.add_dependency(%q<warden>, ["~> 1.0"])
    s.add_dependency(%q<haml>, ["~> 3.0"])
    s.add_dependency(%q<hashie>, ["~> 1.1"])
    s.add_dependency(%q<rubyception>, ["~> 0.1.1"])
    s.add_dependency(%q<jquery-rails>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.1.rc8"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
    s.add_dependency(%q<test_engine>, [">= 0"])
  end
end

