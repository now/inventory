# -*- coding: utf-8 -*-

class Inventory::Dependencies::Runtime
  include Inventory::Dependency

  def require
    require '%s-%d.0' % [name, major]
  end
end
