# -*- coding: utf-8 -*-

class Inventory
  Version = Inventory.new(1, 5, 2){
    def authors
      Authors.new{
        author 'Nikolai Weibull', 'now@disu.se'
      }
    end

    def homepage
      'http://disu.se/software/inventory/'
    end

    def licenses
      Licenses.new{
        license 'LGPLv3+',
                'GNU Lesser General Public License, version 3 or later',
                'http://www.gnu.org/licenses/'
      }
    end

    def dependencies
      Dependencies.new{
        development 'inventory-rake', 1, 6, 0
        development 'inventory-rake-tasks-yard', 1, 4, 0
        development 'lookout', 3, 0, 0
        development 'lookout-rake', 3, 1, 0
        development 'yard', 0, 8, 7
        development 'yard-heuristics', 1, 2, 0
      }
    end

    def package_libs
      %w[author.rb
         authors.rb
         dependency.rb
         dependencies.rb
         dependencies/development.rb
         dependencies/optional.rb
         dependencies/runtime.rb
         extension.rb
         license.rb
         licenses.rb]
    end
  }
end
