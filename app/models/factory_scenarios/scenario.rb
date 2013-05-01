module FactoryScenarios
  class Scenario

    def storage
      FactoryScenarios.storage
    end

    def self.all
      FactoryGirl.factories.find_all{|fact| fact.build_class.to_s == FactoryScenarios.config.user_class }.map do |factory|
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

    def persisted?
      !!find_user
    end

    def name
      @factory.name.to_s
    end

    def enact(do_clear=false)
      clear if do_clear
      if persisted?
        user = find_user
      else
        user = FactoryGirl.create(self.name)
        self.user_id = user.id
      end
      
      return user
    end

    def user_class
      FactoryScenarios.config.user_class.constantize
    end

    def find_user
      user_class.where(id: user_id).first
    end

    def user_id
      user_id = storage[self.name].to_i
    end

    def user_id=(id)
      storage[self.name] = id
    end

    # This doesn't delete associated records.
    # It just lets you re-set the named factory.
    def clear
      storage.delete(self.name)
    end

    def to_param
      name
    end

  end
end