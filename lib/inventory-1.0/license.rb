# -*- coding: utf-8 -*-

# A license used by the project stored in the list of {Licenses} in the
# inventory.
class Inventory::License
  # Sets up a new license NAME, often referred to via ABBREVIATION, than can be
  # found at URL.
  #
  # @param [String] abbreviation
  # @param [String] name
  # @param [String] url
  def initialize(abbreviation, name, url)
    @abbreviation, @name, @url = abbreviation, name, url
  end

  # @return [String] The {#abbreviation} of the license
  def to_s
    abbreviation.dup
  end

  # @return [String] The abbreviation of the {#name} of the license
  attr_reader :abbreviation

  # @return [String] The name of the license
  attr_reader :name

  # @return [String] The URL at which the license can be found
  attr_reader :url
end
