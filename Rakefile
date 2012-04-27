# -*- coding: utf-8 -*-

$:.unshift File.expand_path('../lib', __FILE__)
require 'inventory-1.0'

require 'inventory/rake-1.0'

Inventory::Rake::Tasks.define Inventory::Version, :gem => proc{ |_, s|
  s.author = 'Nikolai Weibull'
  s.email = 'now@bitwi.se'
  s.homepage = 'https://github.com/now/inventory'
}

if (%w'gem:deps:install gem:deps:install:user' & Rake.application.top_level_tasks).empty?
  require 'lookout/rake-3.0'
  Lookout::Rake::Tasks::Test.new
end
