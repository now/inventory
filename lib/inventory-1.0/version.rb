# -*- coding: utf-8 -*-

class Inventory
  Version = Inventory.new(1, 4, 0){
    def dependencies
      Dependencies.new{
        development 'inventory-rake', 1, 4, 0
        development 'lookout', 3, 0, 0
        development 'lookout-rake', 3, 0, 0
        development 'yard', 0, 8, 5
      }
    end

    def package_libs
      %w[dependency.rb
         dependencies.rb
         dependencies/development.rb
         dependencies/optional.rb
         dependencies/runtime.rb
         extension.rb]
    end
  }
end
