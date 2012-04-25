# -*- coding: utf-8 -*-

module Inventory::Dependency
  def initialize(name, major, minor, patch, options = {})
    @name, @major, @minor, @patch = name, major, minor, patch
    instance_exec(&Proc.new) if block_given?
  end

  def to_s
    '%d.%d.%d' % [major, minor, patch]
  end

  def feature
    '%s-%d.0' % [name, major]
  end

  def require
    super feature
  end

  def add_to_gem_specification(specification)
    specification.add_runtime_dependency name, gem_requirement
    self
  end

  attr_reader :name, :major, :minor, :patch

  private

  def gem_requirement
    '~> %s' % (major > 0 ? '%d.%d' % [major, minor] : to_s)
  end
end
