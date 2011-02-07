class Scenario
  attr_reader :name
  
  def self.all
    FactoryGirl.factories.find_all{|fact| fact[1].class_name == :user }.map do |factory|
      new *factory
    end
  end
  
  def self.find(name)
    all.find{|scenario| scenario.name == name }
  end
  
  def initialize(name, factory)
    self.name = name
    @factory = factory
  end
  
  def enact(warden)
    user = Factory.create(@name)
    warden.set_user(user)
  end
  
  def to_param
    name
  end
  
  def name=(name)
    @name = name.to_s
  end
end