# -*- coding: utf-8 -*-

# Contains zero or more {License licenses} of the project.  Licenses can be {#+
# added} and {#each enumerated}.  Licenses are set up by passing a block to
# {#initialize} and calling {#license} inside it.
#
# @example Creating a List of Licenses
#   Licenses.new{
#     license 'LGPLv3+',
#             'GNU Lesser General Public License, version 3 or later',
#             'http://www.gnu.org/licenses/'
#     license 'GPLv3+',
#             'GNU General Public License, version 3 or later',
#             'http://www.gnu.org/licenses/'
#   }
class Inventory::Licenses
  include Enumerable

  # Creates a new list of LICENSES and allows more to be added in the
  # optionally #instance_exec’d block by calling {#license} inside it.
  #
  # @param [License, …] licenses
  # @yield [?]
  def initialize(*licenses)
    @licenses = licenses
    instance_exec(&Proc.new) if block_given?
  end

  private

  # Add a {License} to the list of licenses.
  #
  # @param (see Inventory::License#initialize)
  # @option (see Inventory::License#initialize)
  # @return [self]
  def license(abbreviation, name, url)
    licenses << Inventory::License.new(abbreviation, name, url)
    self
  end

  public

  # @return [Licenses] The authors of the receiver and those of OTHER
  def +(other)
    self.class.new(*(licenses + other.licenses))
  end

  # @overload
  #   Enumerates the licenses.
  #
  #   @yieldparam [License] license
  # @overload
  #   @return [Enumerator<Author>] An Enumerator over the licenses
  def each
    return enum_for(__method__) unless block_given?
    licenses.each do |license|
      yield license
    end
    self
  end

  protected

  attr_reader :licenses
end
