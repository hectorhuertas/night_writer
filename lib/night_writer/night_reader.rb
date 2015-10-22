require_relative 'file_reader'
require_relative 'file_writer'

class NightReader
  attr_reader :file_reader, :file_writer

  def initialize
    @file_reader = FileReader.new
    @file_writer = FileWriter.new
  end

  def read_lines(input)
    puts array=input.split
  end

  def arrarize(input)
    [input[0][0..1],input[1][0..1],input[2][0..1]]
  end


end

if __FILE__ == $0
  #REAL DEAL
  night_reader = NightReader.new
  content = night_reader.file_reader.read.chomp
  puts lines_array = night_reader.read_lines(content)
  puts night_reader.arrarize(lines_array)
  night_reader.file_writer.write(content)
end
