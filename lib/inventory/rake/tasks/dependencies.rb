# -*- coding: utf-8 -*-

class Inventory::Rake::Tasks::Dependencies
  include Rake::DSL

  def initialize(options = {})
    self.inventory = options.fetch(:inventory, Inventory::Rake::Tasks.inventory)
    yield self if block_given?
    define
  end

  def define

  attr_writer :inventory
end
