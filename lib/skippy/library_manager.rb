require 'json'
require 'pathname'

require 'skippy/helpers/file'
require 'skippy/library'
require 'skippy/project'

class Skippy::LibraryManager

  include Enumerable
  include Skippy::Helpers::File

  attr_reader :project

  # @param [Skippy::Project] project
  def initialize(project)
    raise TypeError, 'expected a Project' unless project.is_a?(Skippy::Project)
    @project = project
  end

  # @yield [Skippy::Library]
  def each
    directories(path).each { |lib_path|
      yield Skippy::Library.new(lib_path)
    }
    self
  end

  def empty?
    to_a.empty?
  end

  # @param [String] module_path
  # @return [Skippy::LibModule, nil]
  def find_module(module_path)
    library_name, module_name = module_path.split('/')
    raise ArgumentError, 'expected a module path' if library_name.nil? || module_name.nil?
    library = find { |lib| lib.name == library_name }
    return nil if library.nil?
    library.modules.find { |mod| mod.name == module_name }
  end

  # @param [Pathname, String] source
  def install(source)
    raise Skippy::Project::ProjectNotSavedError unless project.exist?
    library = Skippy::Library.new(source)

    target = path.join(library.name)

    FileUtils.mkdir_p(path)
    FileUtils.copy_entry(source, target)

    project.config.push(:libraries, {
      name: library.name,
      version: library.version,
      source: source
    })

    project.save

    library
  end

  # @return [Integer]
  def length
    to_a.length
  end
  alias :size :length

  # @return [Pathname]
  def path
    project.path('.skippy/libs')
  end

end