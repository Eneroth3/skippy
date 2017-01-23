require 'test_helper'
require 'skippy/library_manager'
require 'skippy/project'

class SkippyLibraryManagerTest < Skippy::Test::Fixture

  attr :project

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
    assert_directory(project.path('.skippy/libs/my_lib'))
    assert_file(project.path('.skippy/libs/my_lib/skippy.json'))
    assert_file(project.path('.skippy/libs/my_lib/src/command.rb'))
    assert_file(project.path('.skippy/libs/my_lib/src/geometry.rb'))
    assert_file(project.path('.skippy/libs/my_lib/src/tool.rb'))
  end

end
