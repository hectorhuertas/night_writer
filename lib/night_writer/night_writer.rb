require_relative 'file_reader'  # => true
require_relative 'file_writer'  # => true

class NightWriter
  attr_reader :file_reader, :file_writer  # => nil

  def initialize
    @file_reader = FileReader.new  # => #<FileReader:0x007fe0b091f990>
    @file_writer = FileWriter.new  # => #<FileWriter:0x007fe0b091f878>
  end

  def encode_to_braille(char)

  end

  def build_third_of_line(input_string,third_position)
    alphabet = {'a'=>%w(0. .. ..), 'b'=>%w(0. 0. ..), 'c'=>%w(00 .. ..)}  # => {"a"=>["0.", "..", ".."], "b"=>["0.", "0.", ".."], "c"=>["00", "..", ".."]}
    a=%w(0. .. ..)                                                        # => ["0.", "..", ".."]
    b=%w(0. 0. ..)                                                        # => ["0.", "0.", ".."]
    c=%w(00 .. ..)                                                        # => ["00", "..", ".."]
    output=''                                                             # => ""
    input_string.each_char do |char|                                      # => "abc"
      alphabet[char][0]                                                   # => "0.", "0.", "00"
      alphabet[char][1]                                                   # => "..", "0.", ".."
      output = output + alphabet[char][third_position]                                 # => "0.", "0.0.", "0.0.00"
      output                                                              # => "0.", "0.0.", "0.0.00"
    end                                                                   # => "abc"
    output                                                                # => "0.0.00"
  end

end

if __FILE__ == $0  # => true

  a=%w(0. .. ..)                     # => ["0.", "..", ".."]
  b=%w(0. 0. ..)                     # => ["0.", "0.", ".."]
  c=%w(00 .. ..)                     # => ["00", "..", ".."]
nw = NightWriter.new                 # => #<NightWriter:0x007fe0b091f9e0 @file_reader=#<FileReader:0x007fe0b091f990>, @file_writer=#<FileWriter:0x007fe0b091f878>>
nw.build_line('abc',0)               # => "0.0.00"
puts ARGV.inspect                    # => nil
puts  content = nw.file_reader.read  # ~> TypeError: no implicit conversion of nil into String
nw.file_writer.write(content)
end

# >> []

# ~> TypeError
# ~> no implicit conversion of nil into String
# ~>
# ~> /Users/hectorhuertas/turing/1module/projects/night_writer/lib/night_writer/file_reader.rb:4:in `read'
# ~> /Users/hectorhuertas/turing/1module/projects/night_writer/lib/night_writer/file_reader.rb:4:in `read'
# ~> /Users/hectorhuertas/turing/1module/projects/night_writer/lib/night_writer/night_writer.rb:41:in `<main>'
