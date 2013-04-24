# -*- coding: utf-8 -*-

# An Inventory keeps track of your Ruby project’s {Inventory#to_s version} and
# its {Inventory#to_a content}.  It also allows you to {#load} your project’s
# source files in a simple manner and track its {#dependencies}.  Add-ons, such
# as [Inventory-Rake](http://disu.se/software/inventory-rake/) and
# [Inventory-Rake-Tasks-YARD](http://disu.se/software/inventory-rake-tasks-yard),
# can also use this information to great effect.
#
# The basic usage pattern is to set your project’s Version constant to an
# instance of this class, where you set the version information and override
# the relevant methods with the information relevant to your project.  For
# example, almost all project will want to override the {#package_libs} method
# with a method that returns an Array of the files relevant to it.
#
# Quite a few methods have definitions that you’ll want to extend, for example,
# {#dependencies}, in which case you simply call super and add your additions
# to its result.
#
# The naming convention of methods is that any method named “X_files” will
# return an Array of complete paths to files of kind X inside the project,
# while any method named “X” will return an Array of paths relative to the
# sub-directory that the method is named after.  For example, “lib_files”
# returns an Array of complete paths to files under the “lib” directory
# ([lib/foo-1.0.rb, …]), while “libs” returns an Array of paths relative to the
# “lib” directory ([foo-1.0.rb]).
#
# See {Dependencies} for more information on managing dependencies.
#
# See {Extension} for more information on adding extensions.
#
# @example Creating an Inventory
#       require 'inventory-1.0'
#
#       class Foo
#         Version = Inventory.new(1, 2, 0){
#           def dependencies
#             super + Dependencies.new{
#               development 'inventory-rake', 1, 3, 0
#               runtime 'bar', 1, 6, 0
#             }
#           end
#
#           def package_libs
#             %w'a.rb
#                b.rb
#                b/c.rb'
#           end
#         }
#       end
class Inventory
  # Sets up an inventory for version MAJOR.MINOR.PATCH for a library whose
  # `lib/PACKAGE/version.rb` is at PATH.  Any block will be #instance_exec’d.
  #
  # @param major [String]
  # @param minor [String]
  # @param patch [String]
  # @param path [String]
  # @raise [ArgumentError] If PATH’s default value can’t be calculated
  # @raise [ArgumentError] If PATH isn’t of the form `lib/PACKAGE/version.rb`
  def initialize(major, minor, patch,
                 path = (m = /\A(.*):\d+(?::in .*)?\z/.match(caller.first) and m[1]))
    @major, @minor, @patch = major, minor, patch
    raise ArgumentError, 'default value of path argument could not be calculated' unless path
    @path = path
    @srcdir, _, @package_path = File.dirname(File.expand_path(path)).rpartition('/lib/')
    @package = @package_path.sub(/-#{Regexp.escape(major.to_s)}\.0\z/, '').gsub('/', '-')
    @package_require = package == package_path.gsub('/', '-') ? '%s-%d.0' % [package_path, major] : package_path
    raise ArgumentError,
      'path is not of the form PATH/lib/PACKAGE/version.rb: %s' % path if
        @srcdir.empty?
    instance_exec(&Proc.new) if block_given?
  end

  # @return [String] The name of the package, as derived from the
  #   {#package_path}
  attr_reader :package

  def version_require
    warn '%s#%s is deprecated and there’s no replacement' % [self.class, __method__]
    File.join(package_path, 'version')
  end

  def lib_directories
    %w[lib]
  end

  # Requires all {#requires}, {Dependencies#require requires} all
  # {#dependencies}, and loads all {#loads}.
  #
  # @return [self]
  def load
    requires.each do |requirement|
      require requirement
    end
    dependencies.require
    loads.each do |load|
      Kernel.load File.expand_path('lib/%s' % load, srcdir)
    end
    self
  end

  # @return [Dependencies] The dependencies of the package
  # @note The default list of dependencies is an {Dependencies#optional
  #   optional} dependency on the inventory package itself.
  def dependencies
    Dependencies.new{
      optional 'inventory', Version.major, Version.minor, Version.patch
    }
  end

  # @return [Array<String>] The files to require when {#load}ing, the default
  #   being empty
  def requires
    []
  end

  # @return [Array<String>] The files to load when {#load}ing, the default
  #   being {#libs}
  def loads
    libs
  end

  # @return [Array<Extension>] The extensions included in the package, the
  #   default being empty
  def extensions
    []
  end

  # @return [Array<String>] The library files belonging to the package that will
  #   be loaded when {#load}ing, the default being empty
  def package_libs
    []
  end

  # @return [Array<String>] The library files to load when {#load}ing, the
  #   default being {#package_libs} inside a directory with the same name as
  #   {#package_require}
  def libs
    package_libs.map{ |e| '%s/%s' % [package_path, e] }
  end

  # @return [Array<String>] Any additional library files, the default being
  #   `{#package_path}-{#major}.0.rb` and `{#package_path}/version.rb`
  def additional_libs
    [package_require, File.join(package_path, 'version')].map{ |e| '%s.rb' % e }
  end

  # @return [Array<String>] All library files, that is, {#libs} +
  #   {#additional_libs}
  def all_libs
    libs + additional_libs
  end

  # @return [Array<String>] The complete paths of {#all_libs all library files}
  #   inside the package
  def lib_files
    all_libs.map{ |e| 'lib/%s' % e }
  end

  # @return [Array<String>] The unit tests included in the package, the default
  #   being {#all_libs}, meaning that there’s one unit test for each library
  #   file
  def unit_tests
    all_libs
  end

  # @return [Array<String>] Any additional unit tests, the default being empty
  def additional_unit_tests
    []
  end

  # @return [Array<String>] All unit tests, that is {#unit_tests} +
  #   {#additional_unit_tests}
  def all_unit_tests
    unit_tests + additional_unit_tests
  end

  # @return [Array<String>] The complete paths of {#all_unit_tests all unit
  #   test} files inside the package
  def unit_test_files
    all_unit_tests.map{ |e| 'test/unit/%s' % e }
  end

  # @return [Array<String>] All test files included in the package, the default
  #   being {#unit_test_files}
  def test_files
    unit_test_files
  end

  # @return [Array<String>] Any additional files included in the package, the
  #   default being README and Rakefile
  def additional_files
    %w'
      README
      Rakefile
    '
  end

  # @return [Array<String>] All files included in the package, that is
  #   {#lib_files} + {#test_files} + {#additional_files} + all files from
  #   {#extensions}
  def files
    lib_files + test_files + additional_files + extensions.map(&:files).flatten
  end

  # @return [Array<String>] Whatever {#files} returns
  def to_a
    files
  end

  # @return [String] The version atoms formatted as {#major}.{#minor}.{#patch}
  def to_s
    '%d.%d.%d' % [major, minor, patch]
  end

  def inspect
    '#<%s: %s %s>' % [self.class, package, self]
  end

  # @return [Integer] The major version atom of the package
  attr_reader :major

  # @return [Integer] The minor version atom of the package
  attr_reader :minor

  # @return [Integer] The patch version atom of the package
  attr_reader :patch

  # @return [String] The path to the file containing the inventory
  attr_reader :path

  # @return [String] The top-level path of the package
  attr_reader :srcdir

  # @return [String] The root sub-directory under the “lib” directory of the
  #   package of the package
  attr_reader :package_path

  # @return [String] The feature to require for the package
  attr_reader :package_require

  load File.expand_path('../inventory/version.rb', __FILE__)
  Version.loads.each do |load|
    Kernel.load File.expand_path('../%s' % load, __FILE__)
  end
end

