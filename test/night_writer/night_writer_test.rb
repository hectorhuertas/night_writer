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

  def  test_it_parses_capital_letters_to_prepare_for_encoding
    writer = NightWriter.new
    assert_equal "^pe^te^r" , writer.parse_string_for_encoding("PeTeR")
  end

  def  test_it_parses_numbers_letters_to_prepare_for_encoding
    writer = NightWriter.new
    assert_equal '#a#c#e#g' , writer.parse_string_for_encoding("1357")
  end

  def test_it_keeps_line_length_under_80_characters
    skip
  end

  def test_it_parses_strings_to_prepare_encoding
    writer = NightWriter.new
    assert_equal "^hi ^peter#g#g!" , writer.parse_string_for_encoding("Hi Peter77!")
  end

  def test_it_builds_first_third_of_output_braille_line
    writer = NightWriter.new
    input = "abc"
    first_line = "0.0.00"
    assert_equal first_line, writer.build_third_of_line(input,0)
  end

  def test_it_builds_second_third_of_output_braille_line
    writer = NightWriter.new
    input = "abc"
    second_line = "..0..."
    assert_equal second_line, writer.build_third_of_line(input,1)
  end

  def test_it_builds_third_third_of_output_braille_line
    writer = NightWriter.new
    input = "abc"
    third_line = "......"
    assert_equal third_line, writer.build_third_of_line(input,2)
  end

  def test_it_encodes_chars_to_braille
    writer = NightWriter.new
    assert_equal "0.\n..\n.." , writer.encode_to_braille('a')
  end
end
