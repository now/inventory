# -*- coding: utf-8 -*-

# An author of the project stored in the list of {Authors} in the inventory.
class Inventory::Author
  # Sets up a new author NAME that can be contacted at EMAIL.
  #
  # @param [String] name
  # @param [String] email
  def initialize(name, email)
    @name, @email = name, email
  end

  # @return [String] The {#name} and {#email} of the author on the
  #   “`name <email>`” format
  def to_s
    '%s <%s>' % [name, email]
  end

  # @return [String] The name of the author
  attr_reader :name

  # @return [String] The email address of the author
  attr_reader :email
end
