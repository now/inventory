# -*- coding: utf-8 -*-

class Inventory
  Version = Inventory.new(1, 1, 2){
    def dependencies
      Dependencies.new{
        development 'lookout', 3, 0, 0
        development 'yard', 0, 7, 0
      }
    end

    def libs
      %w'
        inventory/dependency.rb
        inventory/dependencies.rb
        inventory/dependencies/development.rb
        inventory/dependencies/optional.rb
        inventory/dependencies/runtime.rb
      '
    end

    def additional_libs
      super + %w'
        inventory/rake/tasks-1.0.rb
        inventory/rake/tasks/check.rb
        inventory/rake/tasks/clean.rb
        inventory/rake/tasks/gem.rb
        inventory/rake/tasks/inventory.rb
      '
    end
  }
end
