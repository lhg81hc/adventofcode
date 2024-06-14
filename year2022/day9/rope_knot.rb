module Year2022
  module Day9
    class RopeKnot
      attr_accessor :line_index, :char_index
      attr_reader :type

      def initialize(char_index, line_index, type)
        @char_index = char_index
        @line_index = line_index
        @type = type
      end

      def location
        [char_index, line_index]
      end

      def location=(l)
        @char_index, @line_index = l
      end

      def to_s
        "#{type_abbreviation} [#{location.join(',')}]"
      end

      def type_abbreviation
        case type
        when :head
          'H'
        when :tail
          'T'
        else
          raise ArgumentError, "Invalid type #{type.inspect}"
        end
      end
    end
  end
end
