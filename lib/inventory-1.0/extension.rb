# -*- coding: utf-8 -*-

# An extension represents a sub-directory under the “ext” directory in the
# project.  Such a directory contains source files, usually written in C, that
# interface with the underlying Ruby implementation, and possibly other
# low-level systems, that aren’t otherwise available to Ruby code.
#
# For an inventory, an extension is a set of files that should be included in
# the project and can contain multiple extensions.
# [Inventory-Rake](http://disu.se/software/inventory-rake/) uses information
# found in these extensions to compile them for use from Ruby code.
class Inventory::Extension
  # Creates an extension named NAME.  A block may be given that’ll be
  # \#instance_exec’d in the extension being created so that various methods may
  # be overridden to suit the extension being created.
  #
  # @param [String] name
  # @yield [?]
  def initialize(name)
    @name = name
    instance_exec(&Proc.new) if block_given?
  end

  # @return [String] The sub-directory into the project that contains the
  #   extension, the default being `ext/{#name}`
  def directory
    'ext/%s' % name
  end

  # @return [String] The path into the project that contains the “extconf.rb”
  #   file for the extension, the default being `{#directory}/extconf.rb`
  def extconf
    '%s/extconf.rb' % directory
  end

  # @return [String] The path into the project that contains the “depend”
  #   file for the extension, the default being `{#directory}/depend`
  # @note This file is usually created by hand by invoking `gcc -MM *.c >
  #   depend`
  def depend
    '%s/depend' % directory
  end

  # @return [Array<String>] The source files that make up the extension, the
  #   default being empty
  def sources
    []
  end

  # @return [Array<String>] The complete paths of {#sources} inside the package
  def source_files
    sources.map{ |e| '%s/%s' % [directory, e] }
  end

  # @return [Array<String>] The complete paths to any additional files
  def additional_files
    []
  end

  # @return [Array<String>] All files included in the package, that is
  #   [{#extconf}, {#depend}] + {#source_files} + {#additional_files}
  def files
    [extconf, depend] + source_files + additional_files
  end

  # @return [Array<String>] Whatever {#files} returns
  def to_a
    files
  end

  # @return [String] The receiver’s {#name}
  def to_s
    name
  end

  def inspect
    '#<%s: %s %s>' % [self.class, name, directory]
  end

  # @return [String] The receiver’s {#name}
  attr_reader :name
end
