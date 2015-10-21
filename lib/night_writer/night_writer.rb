require_relative 'file_reader'
require_relative 'file_writer'

class NightWriter
  attr_reader :file_reader, :file_writer

  def initialize
    @file_reader = FileReader.new
    @file_writer = FileWriter.new
  end

  def encode_to_braille(input_string)
    parsed_string = parse_string(input_string)
    encode_line_to_braille(parsed_string)
  end

  def wrap_lines(input_string)
    return [' '] if input_string.empty?
    input_string.length.times do |pos|
      if (pos+1) % 80 == 0
        # input_string[pos+1]
        if not input_string[pos].scan(/[\^#]/).empty?
          input_string.insert(pos,"\n")
        else
          input_string.insert((pos+1),"\n")
        end
      end
    end
    input_string.split()
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
    parsed_array.length.times do |pos|
      if (pos+1) % 80 == 0
        parsed_array[pos+1]
        if not parsed_array[pos].scan(/[\^#]/).empty?
          parsed_array.insert(pos,"\n")
        else
          parsed_array.insert((pos+1),"\n")
        end
      end
    end
    parsed_string=parsed_array.join
  end

  def encode_multiple_lines_to_braille(input_array)
    output_array = input_array.map do |line|
      encode_line_to_braille(line)
    end
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
    alphabet = {'^'=>%w(.. .. .0),'#'=>%w(.0 .0 00),'a'=>%w(0. .. ..), 'b'=>%w(0. 0. ..), 'c'=>%w(00 .. ..)}
    output=''
    input_string.each_char do |char|
      output = output + alphabet[char][third_position]
    end
    output
  end

end

if __FILE__ == $0
  # alphabet = {'a'=>%w(0. .. ..), 'b'=>%w(0. 0. ..), 'c'=>%w(00 .. ..)}
  nw = NightWriter.new
  # nw.parse_string('a'*79 + '^a')
  # nw.parse_string("PeTeR9")
  # nw.build_third_of_line('abc',0)
  puts ARGV.inspect
  ARGV[0]='message.txt'
  ARGV[1]='braille.txt'
  puts ARGV.inspect
  nw.wrap_lines('b')
  nw.encode_multiple_lines_to_braille(["aaa","bbb","ccc"])
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
