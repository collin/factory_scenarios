class Scenario  
  def storage
    FactoryScenarios::Storage
  end
  
  def self.all
    FactoryGirl.factories.find_all{|fact| fact.build_class.to_s == "User" }.map do |factory|
      new factory
    end
  end
  
  def self.find(name)
    all.find{|scenario| scenario.name == name }
  end
  
  def self.clear_all
    all.each(&:clear)
  end
  
  def initialize(factory)
    @factory = factory
  end

  def name
    @factory.name.to_s
  end
  
  def persisted?
    !!find_user
  end
  
  def enact(do_clear=false)
    clear if do_clear
    if persisted?
      user = find_user
    else
      user = Factory.create(self.name)
      storage[self.name] = user.id
    end
    
    return user
  end

  def find_user
    User.where(id: user_id).first
  end

  def user_id
    user_id = storage[self.name].to_i
  end

  # This doesn't delete associated records.
  # It just lets you re-set the named factory.
  def clear
    storage.delete(self.name)
  end
  
  def to_param
    name
  end
  
  def name=(name)
    @name = name.to_s
  end
end