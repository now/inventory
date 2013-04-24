# -*- coding: utf-8 -*-

# A runtime dependency is one that’s needed during runtime.  It’ll be required
# when the library is loaded and added to a Gem specification as a runtime
# dependency.
class Inventory::Dependencies::Runtime
  include Inventory::Dependency
end
