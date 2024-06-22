module Year2022
  module Day10
    class Instruction
      ADDX = 'addx'.freeze
      NOOP = 'noop'.freeze

      attr_reader :type, :value

      def initialize(type, value)
        @type = type
        @value = value
      end

      def number_of_required_cycles
        case type
        when ADDX
          2
        when NOOP
          1
        else
          raise ArgumentError, "Invalid type #{type}"
        end
      end

      def addx?
        type == ADDX
      end

      def noop?
        type == NOOP
      end

      def to_s
        [type, value].compact.join(' ')
      end
    end
  end
end
