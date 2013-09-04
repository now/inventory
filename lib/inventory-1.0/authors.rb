# -*- coding: utf-8 -*-

# Contains zero or more {Author authors} of the project.  Authors can be {#+
# added} and {#each enumerated}.  Authors are set up by passing a block to
# {#initialize} and calling {#author} inside it.
#
# @example Creating a List of Authors
#   Authors.new{
#     author 'A. U. Thor', 'a.u.thor@example.org'
#     author 'W. R. Ither', 'w.r.ither@example.org'
#   }
class Inventory::Authors
  include Enumerable

  # Creates a new list of AUTHORS and allows more to be added in the
  # optionally #instance_exec’d block by calling {#author} inside it.
  #
  # @param [Author, …] authors
  # @yield [?]
  def initialize(*authors)
    @authors = authors
    instance_exec(&Proc.new) if block_given?
  end

  private

  # Add an {Author} to the list of authors.
  #
  # @param (see Inventory::Author#initialize)
  # @option (see Inventory::Author#initialize)
  # @return [self]
  def author(name, email)
    authors << Inventory::Author.new(name, email)
    self
  end

  public

  # @return [Authors] The authors of the receiver and those of OTHER
  def +(other)
    self.class.new(*(authors + other.authors))
  end

  # @overload
  #   Enumerates the authors.
  #
  #   @yieldparam [Author] author
  # @overload
  #   @return [Enumerator<Author>] An Enumerator over the authors
  def each
    return enum_for(__method__) unless block_given?
    authors.each do |author|
      yield author
    end
    self
  end

  protected

  attr_reader :authors
end
