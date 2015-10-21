require 'minitest'
require 'night_writer/night_writer'

class NightWriterTest < Minitest::Test
  def test_class_exists
    assert  NightWriter
  end

  def test_it_can_be_instantiated
    night_writer = NightWriter.new
    assert night_writer
  end

  def test_it_has_a_file_reader
    assert NightWriter.new.file_reader
  end

  def test_parsing_takes_a_string
    night_writer = NightWriter.new
    assert night_writer.parse_string('')
  end

  def test_parsing_returns_a_string
    night_writer = NightWriter.new
    assert_kind_of String, night_writer.parse_string('')
  end

  def test_it_parses_capital_letters
    night_writer = NightWriter.new
    assert_equal "^a^b^c", night_writer.parse_string("ABC")
  end

  def test_it_parses_numbers
    night_writer = NightWriter.new
    assert_equal "#a#b#c", night_writer.parse_string("123")
  end

  def test_it_does_not_parses_punctuation
    night_writer = NightWriter.new
    input = "!',-.?'"
    assert_equal "!',-.?'", night_writer.parse_string(input)
  end

  def test_it_does_not_parses_downcase_letters
    night_writer = NightWriter.new
    assert_equal "abc", night_writer.parse_string("abc")
  end

  def test_it_parses_complex_strings
    night_writer = NightWriter.new
    input = "Hola Peter!, 3-14?"
    output = "^hola ^peter!, #c-#a#d?"
    assert_equal output, night_writer.parse_string("Hola Peter!, 3-14?")
  end

  def test_line_wrapping_takes_a_string
    night_writer = NightWriter.new
    assert night_writer.wrap_lines('')
  end

  def test_line_wrapping_returns_an_array_of_strings
    night_writer = NightWriter.new
    assert_kind_of Array, night_writer.wrap_lines('')
    assert_kind_of String, night_writer.wrap_lines('')[0]
  end

  def test_it_wraps_80_character_lines
    night_writer = NightWriter.new
    input = 'a' * 90
    output = ['a' * 80, 'a' * 10]
    assert_equal output, night_writer.wrap_lines(input)
  end

  def test_line_wrapping_respects_capital_characters
    night_writer = NightWriter.new
    input = 'a'* 79 + '^a'
    output = ['a' * 79, '^a']
    assert_equal output, night_writer.wrap_lines(input)
  end

  def test_line_wrapping_respects_numbers
    night_writer = NightWriter.new
    input = 'a'* 79 + '#b'
    output = ['a' * 79, '#b']
    assert_equal output, night_writer.wrap_lines(input)
  end

  def test_line_wrapping_does_not_respects_punctuation
    night_writer = NightWriter.new
    input = 'a'* 79 + '.,'
    output = ['a' * 79 + '.', ',']
    assert_equal output, night_writer.wrap_lines(input)
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


  def test_it_has_a_file_writer
    assert NightWriter.new.file_writer
  end
end
