# -*- coding: utf-8 -*-

# Contains zero or more {Dependency dependencies} of the project.  Dependencies
# can be {#+ added}, {#require}d, {#each enumerated}, and
# {#add_to_gem_specification added to Gem specifications}.  Dependencies are
# set up by passing a block to {#initialize} and calling {#development},
# {#runtime}, and {#optional} inside it.
#
# @example Creating a List of Dependencies
#   Dependencies.new{
#     development 'inventory-rake', 1, 3, 0
#     runtime 'bar', 1, 6, 0
#   }
class Inventory::Dependencies
  include Enumerable

  # Creates a new list of DEPENDENCIES and allows more to be added in the
  # optionally #instance_exec’d block by calling {#development}, {#runtime},
  # and {#optional} inside it.
  #
  # @param [Array<Dependency>] dependencies
  # @yield [?]
  def initialize(*dependencies)
    @dependencies = dependencies
    instance_exec(&Proc.new) if block_given?
  end

  private

  # Add a {Development} dependency on project NAME, version MAJOR, MINOR,
  # PATCH, along with any OPTIONS.
  #
  # @param (see Inventory::Dependency#initialize)
  # @option (see Inventory::Dependency#initialize)
  def development(name, major, minor, patch, options = {})
    dependencies << Development.new(name, major, minor, patch, options)
    self
  end

  # Add a {Runtime} dependency on project NAME, version MAJOR, MINOR, PATCH,
  # along with any OPTIONS.
  #
  # @param (see Inventory::Dependency#initialize)
  # @option (see Inventory::Dependency#initialize)
  def runtime(name, major, minor, patch, options = {})
    dependencies << Runtime.new(name, major, minor, patch, options)
    self
  end

  # Add an {Optional} dependency on project NAME, version MAJOR, MINOR, PATCH,
  # along with any OPTIONS.
  #
  # @param (see Inventory::Dependency#initialize)
  # @option (see Inventory::Dependency#initialize)
  def optional(name, major, minor, patch, options = {})
    dependencies << Optional.new(name, major, minor, patch, options)
    self
  end

  public

  # @return [Dependencies] The dependencies of the receiver and those of OTHER
  def +(other)
    self.class.new(*(dependencies + other.dependencies))
  end

  # @overload
  #   Enumerates the dependencies.
  #
  #   @yieldparam [Dependency] dependency
  # @overload
  #   @return [Enumerator<Dependency>] An Enumerator over the dependencies
  def each
    return enum_for(__method__) unless block_given?
    dependencies.each do |dependency|
      yield dependency
    end
    self
  end

  # {Dependency#require Require} each dependency in turn.
  # @return [self]
  def require
    map{ |dependency| dependency.require }
    self
  end

  # {Dependency#add_to_gem_specification Add} each dependency to a Gem
  # specification.
  # @param [Gem::Specification] specification
  # @return [self]
  def add_to_gem_specification(specification)
    each do |dependency|
      dependency.add_to_gem_specification specification
    end
    self
  end

  protected

  attr_reader :dependencies
end
