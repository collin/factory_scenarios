class Scenario
  attr_reader :name
  
  def storage
    FactoryScenarios::Storage
  end
  
  def self.all
    FactoryGirl.factories.find_all{|fact| fact[1].class_name == :user }.map do |factory|
      new *factory
    end
  end
  
  def self.find(name)
    all.find{|scenario| scenario.name == name }
  end
  
  def self.clear_all
    all.each(&:clear)
  end
  
  def initialize(name, factory)
    self.name = name
    @factory = factory
  end
  
  def persisted?
    storage.key?(@name)
  end
  
  def enact(do_clear=false)
    clear if do_clear
    if persisted?
      user_id = storage[@name].to_i
      user = User.find(user_id)
    else
      user = Factory.create(@name)
      storage[@name] = user.id
    end
    
    return user
  end

  # This doesn't delete associated records.
  # It just lets you re-set the named factory.
  def clear
    storage.delete(@name)
  end
  
  def to_param
    name
  end
  
  def name=(name)
    @name = name.to_s
  end
end