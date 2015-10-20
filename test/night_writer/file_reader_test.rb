require 'minitest'
require 'night_writer/file_reader'

class FileReaderTest < Minitest::Test
  def test_class_exists
    assert  FileReader
  end

  def test_class_can_be_instantiated
    file_reader = FileReader.new
    assert file_reader
  end
end
