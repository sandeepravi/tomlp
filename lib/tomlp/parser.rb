require 'treetop'

require File.expand_path(File.join(File.dirname(__FILE__), 'token_extensions.rb'))

module TOMLP

  require 'treetop'
  Treetop.load(File.expand_path(File.join(File.dirname(__FILE__), 'tomlp_grammar.treetop')))

  # Methods which help in parsing the content
  #
  class Parser

    @@parser = TomlParser.new

    # Public: Initialize a Parser.
    #
    # name - A String stroring the contents of the file
    def initialize(content)
      @content = content.dup
    end

    # Public: Method to parse the document.
    #
    # Returns the parsed Data Structure
    def parse
      @content += "\n" unless @content.end_with?("\n")
      tree = @@parser.parse(@content)
      Parser.clean_tree(tree)
      tree.evaluate
    end

    private

    def self.clean_tree(root_node)
      return if(root_node.elements.nil?)
      root_node.elements.delete_if{|node| node.class.name == "Treetop::Runtime::SyntaxNode" }
      root_node.elements.each {|node| self.clean_tree(node) }
    end
  end
end
