module FactoryScenarios
  class Scenario
    attr_reader :name

    def storage
      FactoryScenarios::Storage
    end

    def self.all
      FactoryGirl.factories.find_all{|fact| fact.build_class.to_s == FactoryScenarios.config.user_class }.map do |factory|
        new factory.name, factory
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
        user_id = storage[self.name].to_i
        user = Spree::User.find(user_id)
      else
        user = Factory.create(self.name)
        storage[self.name] = user.id
      end

      return user
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
end