# -*- coding: utf-8 -*-

Expectations do
  expect 'a/lib/a/version.rb' do
    Inventory.new(1, 0, 0, 'a/lib/a/version.rb').path
  end

  expect 'a' do
    Inventory.new(1, 0, 0, 'a/lib/a/version.rb').package_path
  end

  expect 'a' do
    Inventory.new(1, 0, 0, 'a/lib/a/version.rb').package
  end

  expect 'a-1.0' do
    Inventory.new(1, 0, 0, 'a/lib/a/version.rb').package_require
  end

  expect %w[LGPLv3+] do
    Inventory::Version.licenses.map(&:to_s)
  end

  expect ['Nikolai Weibull <now@disu.se>'] do
    Inventory::Version.authors.map(&:to_s)
  end
end
