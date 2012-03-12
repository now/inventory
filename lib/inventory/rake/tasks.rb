# -*- coding: utf-8 -*-

require 'rake'

class Inventory; module Rake end end

module Inventory::Rake::Tasks
  %w'clean gem inventory'.each do |file|
    load File.expand_path('../tasks/%s.rb' % file, __FILE__)
  end

  @mostlycleanfiles, @cleanfiles, @distcleanfiles = [], [], []

  class << self
    attr_accessor :inventory

    attr_reader :mostlycleanfiles, :cleanfiles, :distcleanfiles

    def define(inventory, options = {})
      self.inventory = inventory
      Clean.define
      Inventory.new(:inventory => inventory)
      Gem.new(:inventory => inventory, &(options.fetch(:gem, proc{ })))
    end
  end
end
