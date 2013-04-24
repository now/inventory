# -*- coding: utf-8 -*-

# An optional dependency is one that may or may not be needed during runtime.
# It won’t be required when the library is loaded, but it will be added to a
# Gem specification as a runtime dependency.
class Inventory::Dependencies::Optional
  include Inventory::Dependency

  # Do nothing.
  # @return [nil]
  def require
    nil
  end
end
