# -*- coding: utf-8 -*-

class Inventory::Dependencies::Development
  include Inventory::Dependency

  def add_to_gem_specification(specification)
    specification.add_development_dependency name, gem_requirement
    self
  end
end
