# -*- coding: utf-8 -*-

Expectations do
  expect %w'test' do
    Inventory::Dependencies.new{
      development 'test', 1, 0, 0
    }.map(&:name)
  end
end
