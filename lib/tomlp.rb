require "tomlp/version"
require "tomlp/parser"

module TOMLP
  VERSION = "0.0.1" 

  extend self

  # Public: Parse the text passed as arguement
  #
  # content - A String containing the entire content of the File in text format
  #
  # Returns the parsed Data Structure
  def parse(content)
    TOMLP::Parser.new(content).parse
  end

  # Public: Parse the contents of the file that is passed as arguement
  #
  # filename - A String containing the filename that needs to be parsed
  #
  # Returns the parsed Data Structure
  def load(filename)
    file_content = File.open(filename).read
    TOMLP::Parser.new(file_content).parse
  end
end
