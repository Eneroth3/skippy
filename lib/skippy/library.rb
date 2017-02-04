require 'json'
require 'pathname'

require 'skippy/helpers/file'
require 'skippy/config'
require 'skippy/config_accessors'
require 'skippy/lib_module'

class Skippy::Library

  extend Skippy::ConfigAccessors

  include Skippy::Helpers::File

  CONFIG_FILENAME = 'skippy.json'.freeze

  attr_reader :path

  config_attr_reader :title, key: :name # TODO(thomthom): Clean up this kludge.
  config_attr_reader :version

  class LibraryNotFoundError < Skippy::Error; end

  def initialize(path)
    @path = Pathname.new(path)
    raise LibraryNotFoundError, @path.to_s unless @path.directory?
    # noinspection RubyResolve
    @config = Skippy::Config.load(config_file)
  end

  def name
    path.basename.to_s
  end

  def modules
    libs = modules_path.children(false).select { |file|
      file.extname.casecmp('.rb').zero?
    }
    libs.map! do |lib|
      path = modules_path.join(lib)
      Skippy::LibModule.new(path)
    end
    libs
  end

  def to_s
    name
  end

  private

  def config_file
    path.join(CONFIG_FILENAME)
  end

  def modules_path
    # TODO(thomthom): Make this configurable and default to 'lib'?
    path.join('src')
  end

end
