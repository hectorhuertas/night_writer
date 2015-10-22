require 'minitest'
require 'night_writer/night_reader'

class NightReaderTest < Minitest::Test
  def test_class_exists
    assert  NightReader
  end

  def test_it_can_be_instantiated
    night_writer = NightReader.new
    assert night_writer
  end

end
