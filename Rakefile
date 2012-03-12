# -*- coding: utf-8 -*-

$:.unshift File.expand_path('../lib', __FILE__)
require 'lookout/rake/tasks'
require 'inventory/rake/tasks'
require 'inventory/version'

Lookout::Rake::Tasks.manifest = Inventory::Version
Lookout::Rake::Tasks::Test.new
Inventory::Rake::Tasks.define Inventory::Version, :gem => proc{ |_, s|
  s.author = 'Nikolai Weibull'
  s.email = 'now@bitwi.se'
  s.homepage = 'https://github.com/now/inventory'
}
