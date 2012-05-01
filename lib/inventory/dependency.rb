# -*- coding: utf-8 -*-

module Inventory::Dependency
  def initialize(name, major, minor, patch, options = {})
    @name, @major, @minor, @patch = name, major, minor, patch
    @feature = options.fetch(:feature, '%s-%d.0' % [name.gsub('-', '/'), major])
    instance_exec(&Proc.new) if block_given?
  end

  def to_s
    [major, minor, patch].join('.')
  end

  def require
    super feature
  end

  def add_to_gem_specification(specification)
    specification.add_runtime_dependency name, gem_requirement
    self
  end

  attr_reader :name, :major, :minor, :patch, :feature

  private

  def gem_requirement
    '~> %s' % (major > 0 ? '%d.%d' % [major, minor] : to_s)
  end
end
