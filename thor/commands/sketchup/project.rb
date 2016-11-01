require 'json'
require 'pathname'

require_relative 'namespace'

class Skippy::Project

  PROJECT_FILENAME = 'skippy.json'.freeze

  attr_reader :namespace, :path

  def initialize(path)
    @path = find_project_path(path) || path
  end

  def exist?
    File.exist?(filename)
  end

  def filename
    File.join(@path, PROJECT_FILENAME)
  end

  def namespace=(namespace)
    @namespace = Skippy::Namespace.new(namespace)
  end

  def save
    File.write(filename, to_json)
  end

  def to_json
    project_config = {
      namespace: @namespace.to_s,
      name: 'Untitled',
      description: 'Lorem Ipsum'
    }
    JSON.pretty_generate(project_config)
  end

  private

  def find_project_path(path)
    pathname = Pathname.new(path)
    loop do
      project_file = pathname.join(PROJECT_FILENAME)
      return pathname if project_file.exist?
      break if pathname.root?
      pathname = pathname.parent
    end
    nil
  end

end
