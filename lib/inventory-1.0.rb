# -*- coding: utf-8 -*-

class Inventory
  def initialize(major, minor, patch,
                 path = (m = /\A(.*):\d+(?::in .*)?\z/.match(caller.first) and m[1]),
                 &block)
    @major, @minor, @patch = major, minor, patch
    raise ArgumentError, 'default value of path argument could not be calculated' unless path
    @path = path
    @srcdir, _, @package_path = File.dirname(File.expand_path(path)).rpartition('/lib/')
    @package_require = '%s-%d.0' % [package, major]
    raise ArgumentError,
      'path is not of the form PATH/lib/PACKAGE/version.rb: %s' % path if
        @srcdir.empty?
    instance_exec(&Proc.new) if block_given?
  end

  def package
    package_path.gsub('/', '-')
  end

  def version_require
    File.join(package_path, 'version')
  end

  def lib_directories
    %w'lib'
  end

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

  def dependencies
    Dependencies.new{
      optional 'inventory', Version.major, Version.minor, Version.patch
    }
  end

  def requires
    []
  end

  def loads
    libs
  end

  def libs
    []
  end

  def additional_libs
    [package_require, version_require].map{ |e| '%s.rb' % e }
  end

  def all_libs
    libs + additional_libs
  end

  def lib_files
    all_libs.map{ |e| 'lib/%s' % e }
  end

  def unit_tests
    all_libs
  end

  def additional_unit_tests
    []
  end

  def all_unit_tests
    unit_tests + additional_unit_tests
  end

  def unit_test_files
    all_unit_tests.map{ |e| 'test/unit/%s' % e }
  end

  def test_files
    unit_test_files
  end

  def additional_files
    %w'
      README
      Rakefile
    '
  end

  def files
    lib_files + test_files + additional_files
  end

  def to_a
    files
  end

  def to_s
    '%d.%d.%d' % [major, minor, patch]
  end

  def inspect
    '#<%s: %s %s>' % [self.class, package, self]
  end

  attr_reader :major, :minor, :patch, :path, :srcdir, :package_path, :package_require

  load File.expand_path('../inventory/version.rb', __FILE__)
  Version.loads.each do |load|
    Kernel.load File.expand_path('../%s' % load, __FILE__)
  end
end

