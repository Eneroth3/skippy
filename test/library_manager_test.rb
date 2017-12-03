require 'test_helper'
require 'skippy/library_manager'
require 'skippy/lib_module'
require 'skippy/project'

class SkippyLibraryManagerTest < Skippy::Test::Fixture

  attr_reader :project

  def setup
    super
    use_fixture('my_project')
    @project = Skippy::Project.new(work_path)
  end

  def test_that_it_can_install_library
    library_source = fixture('my_lib')
    assert_empty(project.libraries)

    result = project.libraries.install(library_source)

    assert_kind_of(Skippy::Library, result)

    assert_equal(1, project.libraries.size)
    assert_directory(project.path('.skippy/libs/my-lib'))
    assert_file(project.path('.skippy/libs/my-lib/skippy.json'))
    assert_file(project.path('.skippy/libs/my-lib/modules/command.rb'))
    assert_file(project.path('.skippy/libs/my-lib/modules/geometry.rb'))
    assert_file(project.path('.skippy/libs/my-lib/modules/gl.rb'))
    assert_file(project.path('.skippy/libs/my-lib/modules/gl/control.rb'))
    assert_file(project.path('.skippy/libs/my-lib/modules/gl/container.rb'))
    assert_file(project.path('.skippy/libs/my-lib/modules/tool.rb'))
  end

  def test_that_it_can_find_library_module
    library_source = fixture('my_lib')
    project.libraries.install(library_source)

    result = project.libraries.find_module('my-lib/command')
    assert_kind_of(Skippy::LibModule, result)
    assert_equal('my-lib/command', result.name)
  end

end
