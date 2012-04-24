# -*- coding: utf-8 -*-

require 'lookout/rake/tasks-1.0'

$:.unshift File.expand_path('../lib', __FILE__)
require 'inventory/rake/tasks-1.0'
require 'inventory-1.0'

Inventory::Rake::Tasks.define Inventory::Version, :gem => proc{ |_, s|
  s.author = 'Nikolai Weibull'
  s.email = 'now@bitwi.se'
  s.homepage = 'https://github.com/now/inventory'
}
Lookout::Rake::Tasks::Test.new
