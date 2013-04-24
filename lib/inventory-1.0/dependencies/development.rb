# -*- coding: utf-8 -*-

# A development dependency is one that’s needed during development of a
# project.  It won’t be required when the library is loaded, but it will be
# added to a Gem specification as a development dependency.
class Inventory::Dependencies::Development
  include Inventory::Dependency

  # Do nothing.
  # @return [nil]
  def require
    nil
  end

  # Add the receiver as a development dependency to SPECIFICATION.
  # @param [Gem::Specification] specification
  # @return [self]
  def add_to_gem_specification(specification)
    specification.add_development_dependency name, gem_requirement
    self
  end
end
