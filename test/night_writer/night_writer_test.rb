require 'minitest'
require 'minitest/autorun'
require 'night_writer/night_writer'

class NightWriterTest < Minitest::Test
  def test_class_exists
    assert  NightWriter
  end

  def test_class_can_be_instantiated
    writer = NightWriter.new
    assert writer
  end

  def test_it_has_a_file_reader
    assert NightWriter.new.file_reader
  end

  def test_it_has_a_file_writer
    assert NightWriter.new.file_writer
  end

  def test_it_writes_braille_text
    skip
  end

  def test_it_encodes_to_braille
    skip
  end

end
