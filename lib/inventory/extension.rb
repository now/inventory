# -*- coding: utf-8 -*-

class Inventory::Extension
  def initialize(name)
    @name = name
    instance_exec(&Proc.new) if block_given?
  end

  def directory
    'ext/%s' % name
  end

  def extconf
    '%s/extconf.rb' % directory
  end

  def depend
    '%s/depend' % directory
  end

  def sources
    []
  end

  def source_files
    sources.map{ |e| '%s/%s' % [directory, e] }
  end

  def additional_files
    []
  end

  def files
    [extconf, depend] + source_files + additional_files
  end

  def to_a
    files
  end

  def to_s
    name
  end

  def inspect
    '#<%s: %s %s>' % [self.class, name, directory]
  end

  attr_reader :name
end
