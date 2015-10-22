require_relative 'file_reader'
require_relative 'file_writer'

class NightWriter
  attr_reader :file_reader, :file_writer

  def initialize
    @file_reader = FileReader.new
    @file_writer = FileWriter.new
  end

  def parse_string(input_string)
    input_array=input_string.split('')
    parsed_array=input_array.map do |char|
      if not char.scan(/[0-9]/).empty?
        number_to_char_table = %w(j a b c d e f g h i)
        '#'+ number_to_char_table[char.to_i]
      elsif not char.scan(/[A-Z]/).empty?
        '^'+char.downcase
      else
        char
      end
    end
    parsed_array=parsed_array.join.split('')
    parsed_string=parsed_array.join
  end

  def wrap_lines(input_string)
    return [' '] if input_string.empty?
    output_string = ''
    if input_string.length > 40
      (input_string.length / 40).times do
        if input_string[39].scan(/[\^#]/).empty?
          output_string += input_string.slice!(input_string[0..39]) + "\n"
        else
          output_string += input_string.slice!(input_string[0..38]) + "\n"
        end
      end
    end
    output_string+=input_string
    output_string

    output_string.split("\n")
  end

  def encode_line_to_braille(input_string)
    braille_output=''
    braille_output+=build_third_of_line(input_string,0)
    braille_output+="\n"
    braille_output+=build_third_of_line(input_string,1)
    braille_output+="\n"
    braille_output+=build_third_of_line(input_string,2)
    braille_output
  end

  def build_third_of_line(input_string,third_position)
    # alphabet = {'^'=>%w(.. .. .0),'#'=>%w(.0 .0 00),'a'=>%w(0. .. ..), 'b'=>%w(0. 0. ..), 'c'=>%w(00 .. ..)}
    alphabet = {'^'=>%w(.. .. .0),'#'=>%w(.0 .0 00),
    "a" => ["0.", "..", ".."],
   "b" => ["0.", "0.", ".."],
   "c" => ["00", "..", ".."],
   "d" => ["00", ".0", ".."],
   "e" => ["0.", ".0", ".."],
   "f" => ["00", "0.", ".."],
   "g" => ["00", "00", ".."],
   "h" => ["0.", "00", ".."],
   "i" => [".0", "0.", ".."],
   "j" => [".0", "00", ".."],
   "k" => ["0.", "..", "0."],
   "l" => ["0.", "0.", "0."],
   "m" => ["00", "..", "0."],
   "n" => ["00", ".0", "0."],
   "o" => ["0.", ".0", "0."],
   "p" => ["00", "0.", "0."],
   "q" => ["00", "00", "0."],
   "r" => ["0.", "00", "0."],
   "s" => [".0", "0.", "0."],
   "t" => [".0", "00", "0."],
   "u" => ["0.", "..", "00"],
   "v" => ["0.", "0.", "00"],
   "w" => [".0", "00", ".0"],
   "x" => ["00", "..", "00"],
   "y" => ["00", ".0", "00"],
   "z" => ["0.", ".0", "00"],
   " " => ["..", "..", ".."],
   "!" => ["..", "00", "0."],
   "'" => ["..", "..", "0."],
   "," => ["..", "0.", ".."],
   "-" => ["..", "..", "00"],
   "." => ["..", "00", ".0"],
   "?" => ["..", "0.", "00"]}
    output=''
    input_string.each_char do |char|
      output = output + alphabet[char][third_position]
    end
    output
  end

  def encode_multiple_lines_to_braille(input_array)
    output_array = input_array.map do |line|
      encode_line_to_braille(line)
    end
  end

  def build_output_string(input_array)
    output_string = ''
    input_array.each do |line|
      output_string += line + "\n"
    end
    output_string.chomp
  end

end

if __FILE__ == $0
  #REAL DEAL
  night_writer = NightWriter.new
  input_roman = night_writer.file_reader.read.chomp
  parsed_roman = night_writer.parse_string(input_roman)
  wrapped_roman = night_writer.wrap_lines(parsed_roman)
  multiline_braille = night_writer.encode_multiple_lines_to_braille(wrapped_roman)
  output_string = night_writer.build_output_string(multiline_braille)
  night_writer.file_writer.write(output_string)




  #TESTS
  # nw = NightWriter.new
  # nw.parse_string('a'*79 + '^a')
  # nw.parse_string("PeTeR9")
  # nw.build_third_of_line('abc',0)
  # puts ARGV.inspect
  # ARGV[0]='message.txt'
  # ARGV[1]='braille.txt'
  # puts ARGV.inspect
  # nw.wrap_lines('b'*39+'ca'+'bbbb')
  # nw.encode_multiple_lines_to_braille(["aaa","bbb","ccc"])
  # puts  content = nw.file_reader.read.chomp               # ~> Errno::ENOENT: No such file or directory @ rb_sysopen - message.txt
  # puts  content = nw.file_reader.read.chomp
  # puts parsed_content=nw.parse_string(content).inspect
  # puts parsed_content=nw.parse_string(content)
  # puts "^acb^ba#a#a#c#c".inspect
  # puts "^acb^ba#a#a#c#c".class
  # puts nw.encode_characters_to_braile("^acb^ba#a#a#c#c")
  # #
  # puts nw.encode_characters_to_braile(parsed_content)
  # nw.encode_to_braille(content).inspect
  # puts content = nw.parse_string(content)
  # nw.encode_characters_to_braile(content)
  # nw.file_writer.write(content)
end
