# -*- coding: utf-8 -*-

require 'lookout/rake/tasks'

$:.unshift File.expand_path('../lib', __FILE__)
require 'inventory/rake/tasks'
require 'inventory'

Inventory::Rake::Tasks.define Inventory::Version, :gem => proc{ |_, s|
  s.author = 'Nikolai Weibull'
  s.email = 'now@bitwi.se'
  s.homepage = 'https://github.com/now/inventory'
}
Lookout::Rake::Tasks::Test.new
