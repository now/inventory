# -*- coding: utf-8 -*-

# Some form of dependency of this project.  A dependency can be {#require}d,
# {#add_to_gem_specification added to a gem specification}, and has various
# information associated with it: {#name}, {#major}, {#minor}, {#patch}, and
# {#feature}.
module Inventory::Dependency
  # Sets up a dependency on project NAME, version MAJOR, MINOR, PATCH, along
  # with any OPTIONS.  Any methods may be overridden on the instance in the
  # optionally #instance_exec’d block, if a dependency has any non-standard
  # requirements.
  #
  # @param [String] name
  # @param [Integer] major
  # @param [Integer] minor
  # @param [Integer] patch
  # @param [Hash] options
  # @option options [String] :feature ('%s-%s.0' % [name.gsub('-', '/'),
  #   major]) The name of the feature to load
  def initialize(name, major, minor, patch, options = {})
    @name, @major, @minor, @patch = name, major, minor, patch
    @altfeature = nil
    @feature = options.fetch(:feature){
      @altfeature = '%s-%d.0' % [name.gsub('-', '/'), major]
      '%s-%d.0' % [name, major]
    }
    instance_exec(&Proc.new) if block_given?
  end

  # @return [Boolean] The result of requiring {#feature}
  def require
    super feature
  rescue LoadError => e
    if not e.respond_to? :path or e.path.end_with? feature
      begin
        super @altfeature
      rescue LoadError
        raise e
      end
    end
  end

  # Add the receiver as a runtime dependency to SPECIFICATION.
  # @param [Gem::Specification] specification
  # @return [self]
  def add_to_gem_specification(specification)
    specification.add_runtime_dependency name, gem_requirement
    self
  end

  # @return [String] The version atoms on the form {#major}.{#minor}.{#patch}
  def to_s
    [major, minor, patch].join('.')
  end

  # @return [String] The name of the project that this dependency pertains to
  attr_reader :name

  # @return [Integer] The major version atom of the dependency
  attr_reader :major

  # @return [Integer] The minor version atom of the dependency
  attr_reader :minor

  # @return [Integer] The patch version atom of the dependency
  attr_reader :patch

  # @return [String] The name of the feature to {#require}
  attr_reader :feature

  private

  # Returns the version range to use in {#add_to_gem_specification}.  The
  # default is to use `~>` {#major}.{#minor} if {#major} > 0 and `~>`
  # {#major}.{#minor}.{#patch} otherwise.  The reasoning here is that the
  # version numbers are using [semantic versioning](http://semver.org) with the
  # unfortunate use of minor and patch as a fake major/minor combination when
  # major is 0, which is most often the case for Ruby projects.  Start your
  # major versions at 1 and you’ll avoid this misuse of version numbers.
  #
  # @return [String]
  def gem_requirement
    '~> %s' % (major > 0 ? '%d.%d' % [major, minor] : to_s)
  end
end
