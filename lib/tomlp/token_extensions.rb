module Toml

  require 'date'

  class IntegerLiteral < Treetop::Runtime::SyntaxNode
    def evaluate
      return self.text_value.to_i
    end
  end

  class StringLiteral < Treetop::Runtime::SyntaxNode
    def evaluate
      string = self.text_value
      output = ""
      length = self.text_value.length
      count = 0
      while count < length
        if string[count] == "\\"
          count += 1
          case string[count]
          when "t"
            output << "\t"
          when "n"
            output << "\n"
          when "n"
            output << '"'
          when '"'
            output << "\\"
          when "r"
            output << "\r"
          end
        elsif string[count] != "\""
          output << string[count]
        end
        count += 1
      end
      return output
    end
  end

  class FloatLiteral < Treetop::Runtime::SyntaxNode
    def evaluate
      return self.text_value.to_f
    end
  end

  class BooleanLiteral < Treetop::Runtime::SyntaxNode
    def evaluate
      return eval self.text_value
    end
  end

  class TrueLiteral < Treetop::Runtime::SyntaxNode
    def evaluate
      return eval self.text_value
    end
  end

  class FalseLiteral < Treetop::Runtime::SyntaxNode
    def evaluate
      return eval self.text_value
    end
  end

  class DateTime < Treetop::Runtime::SyntaxNode
    def evaluate
      return ::DateTime.parse self.text_value
    end
  end

  class ArrayDS < Treetop::Runtime::SyntaxNode
    def evaluate
      #array = self.text_value
      #array[0..-2] if array[-1] == ","
      return eval self.text_value
    end
  end

  class Identifier < Treetop::Runtime::SyntaxNode
    def evaluate
      return self.text_value
    end
  end

  class AssignmentOperator < Treetop::Runtime::SyntaxNode
    def evaluate
      return
    end
  end

  class KeyValue < Treetop::Runtime::SyntaxNode
    def evaluate
      values = self.elements.map {|x| x.evaluate}
      key_value = {}
      key_value[values[0]] = values[2]
      return key_value
    end
  end

  class KeyValueList < Treetop::Runtime::SyntaxNode
    def evaluate
      key_value_list = {}
      self.elements.each do |x|
        key_value_list.merge!(x.evaluate)
      end
      return key_value_list
    end
  end

  class KeyGroup < Treetop::Runtime::SyntaxNode
    def evaluate
      self.elements.map {|x| x.evaluate}
    end
  end

  class KeyName < Treetop::Runtime::SyntaxNode
    def evaluate
      self.text_value.split(".")
    end
  end

  class CommentLine < Treetop::Runtime::SyntaxNode
    def evaluate
      return self.text_value
    end
  end

  class Expression < Treetop::Runtime::SyntaxNode
    def evaluate
      return self.text_value
    end
  end
  
  class Body < Treetop::Runtime::SyntaxNode

    def evaluate
      parse(self.elements.map {|x| x.evaluate})
    end

    # TODO:: Refactor this method
    def parse(ds)
      final_hash = {}
      current_key, inner_key = nil, nil
      current_hash = final_hash
      ds.each_with_index do |value, index|
        if value.is_a? Hash
          if current_key == nil
            current_hash.merge!(value)
          elsif inner_key
            current_hash[inner_key].merge!(value)
          else
            current_hash[current_key].merge!(value)
          end
        elsif value.is_a? Array
          value = value.first
          parent_key = value.count > 1 ? value[-2] : value.first
          if parent_key == current_key
            current_hash = final_hash[current_key]
            inner_key = value.last
            current_hash[inner_key] = {}
          elsif inner_key && parent_key == inner_key
            current_hash = current_hash[inner_key]
            inner_key = value.last
            current_hash[inner_key] = {}
          elsif value.count > 1
            value.each_with_index do |key, nindex|
              current_hash[key] = {}
              current_hash = current_hash[key] if nindex + 1 < value.count
            end
            inner_key = value.last
            current_key = value.first
          else
            current_hash = final_hash
            current_key = value.first
            inner_key = nil
            final_hash[current_key] = {}
          end
        end
      end
      final_hash
    end
  end

end
