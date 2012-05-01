# -*- coding: utf-8 -*-

class Inventory::Dependencies
  include Enumerable

  def initialize(*dependencies)
    @dependencies = dependencies
    instance_exec(&Proc.new) if block_given?
  end

  def +(other)
    self.class.new(*(dependencies + other.dependencies))
  end

  def each
    return enum_for(__method__) unless block_given?
    dependencies.each do |dependency|
      yield dependency
    end
    self
  end

  def require
    map{ |dependency| dependency.require }
  end

  def add_to_gem_specification(specification)
    each do |dependency|
      dependency.add_to_gem_specification specification
    end
    self
  end

  protected

  attr_reader :dependencies

  private

  def development(name, major, minor, patch, options = {})
    dependencies << Development.new(name, major, minor, patch, options)
    self
  end

  def runtime(name, major, minor, patch, options = {})
    dependencies << Runtime.new(name, major, minor, patch, options)
    self
  end

  def optional(name, major, minor, patch, options = {})
    dependencies << Optional.new(name, major, minor, patch, options)
    self
  end
end
