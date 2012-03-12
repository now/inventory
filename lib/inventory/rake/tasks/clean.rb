# -*- coding: utf-8 -*-

class Inventory::Rake::Tasks::Clean
  include Rake::DSL

  def initialize(name, files = [])
    @name, @files = name, files
    define
  end

  def define
    task name do
      rm files, :force => true
    end
  end

  attr_accessor :name, :files
end
