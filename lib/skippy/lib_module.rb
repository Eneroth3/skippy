require 'pathname'

require 'skippy/library'

class Skippy::LibModule

  attr_reader :path

  class ModuleNotFoundError < Skippy::Error; end

  # @param [String] path
  def initialize(path)
    @path = Pathname.new(path)
    raise ModuleNotFoundError, @path.to_s unless @path.file?
  end

  # @param [String]
  def basename
    path.basename('.*').to_s
  end

  # @return [Skippy::Library]
  def library
    Skippy::Library.new(library_path)
  end

  # @param [String]
  def name
    "#{library_name}/#{basename}"
  end

  # @param [String]
  def to_s
    name
  end

  private

  def library_name
    library_path.basename.to_s
  end

  def library_path
    # Modules are located in the 'src' directory of the library.
    path.parent.parent
  end

end
