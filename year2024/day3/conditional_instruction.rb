module Year2024
  module Day3
    class ConditionalInstruction
      RE_PATTERN = /do\(\)|don't\(\)/.freeze
      DO_INSTRUCTION = 'do()'.freeze
      DONT_INSTRUCTION = "don't()".freeze

      attr_reader :str

      def initialize(str)
        @str = str
      end

      def do_instruction?
        str == DO_INSTRUCTION
      end

      def dont_instruction?
        str == DONT_INSTRUCTION
      end

      def valid?
        !str.empty? && str == DO_INSTRUCTION || str == DONT_INSTRUCTION
      end
    end
  end
end
