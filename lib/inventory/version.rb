# -*- coding: utf-8 -*-

class Inventory
  Version = Inventory.new(1, 4, 0){
    def dependencies
      Dependencies.new{
        development 'inventory-rake', 1, 3, 0
        development 'lookout', 3, 0, 0
        development 'lookout-rake', 3, 0, 0
        development 'yard', 0, 8, 0
      }
    end

    def libs
      %w'
        inventory/dependency.rb
        inventory/dependencies.rb
        inventory/dependencies/development.rb
        inventory/dependencies/optional.rb
        inventory/dependencies/runtime.rb
        inventory/extension.rb
      '
    end
  }
end
