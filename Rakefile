# -*- coding: utf-8 -*-

require 'lookout/rake/tasks-3.0'

$:.unshift File.expand_path('../lib', __FILE__)
require 'inventory/rake/tasks-1.0'
require 'inventory-1.0'

Inventory::Rake::Tasks.define Inventory::Version, :gem => proc{ |_, s|
  s.author = 'Nikolai Weibull'
  s.email = 'now@bitwi.se'
  s.homepage = 'https://github.com/now/inventory'

  s.add_development_dependency 'lookout', '~> 3.0'
  s.add_development_dependency 'yard', '~> 0.7.0'
}
Lookout::Rake::Tasks::Test.new
