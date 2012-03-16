module FactoryScenarios::Mail
  autoload :Preview, "factory_scenarios/mail/preview"
  @@previews = {}

  def self.register(name, &block)
    preview = Preview.new
    preview.instance_eval(&block)
    preview.name(name)
    (@@previews[preview.mailer.name] ||= {})[name] = preview
    preview
  end

  def self.registrations(&block)
    @@previews = {}
    instance_eval(&block)
  end

  def self.previews
    @@previews
  end
end
