# -*- coding: utf-8 -*-

Expectations do
  expect %w'test' do
    Inventory::Dependencies.new{
      development 'test', 1, 0, 0
    }.map(&:name)
  end

  expect LoadError do
    Inventory::Dependencies.new{
      runtime '-this-package-does-not-exist-so-do-not-create-it', 1, 0, 0
    }.require
  end

  expect LoadError do
    Inventory::Dependencies.new{
      runtime '-this-package-does-not-exist-so-do-not-create-it', 1, 0, 0,
        :feature => '-this-package-does-not-exist-so-do-not-create-it'
    }.require
  end
end
