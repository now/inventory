# -*- coding: utf-8 -*-

class Inventory
  Version = Inventory.new(1, 0, 0){
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
