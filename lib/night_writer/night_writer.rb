require_relative 'file_reader'
require_relative 'file_writer'

class NightWriter
  attr_reader :file_reader, :file_writer

  def initialize
    @file_reader = FileReader.new
    @file_writer = FileWriter.new
  end

end

if __FILE__ == $0
nw = NightWriter.new
puts ARGV.inspect
puts  content = nw.file_reader.read
nw.file_writer.write(content)
end
