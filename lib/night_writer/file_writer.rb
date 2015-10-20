class FileWriter
  def write(content)
    filename = ARGV[1]
    file_handle = File.open(filename, "w")
    file_handle.write(content)
    file_handle.close
  end
end
