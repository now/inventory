# -*- coding: utf-8 -*-

require 'inventory'

class Inventory
  Version = Inventory.new(0, 2, 2){
    def additional_libs
      super + %w'
        inventory/rake/tasks.rb
        inventory/rake/tasks/check.rb
        inventory/rake/tasks/clean.rb
        inventory/rake/tasks/gem.rb
        inventory/rake/tasks/inventory.rb
      '
    end
  }
end
