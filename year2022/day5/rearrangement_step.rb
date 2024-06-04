module Year2022
  module Day5
    class RearrangementStep
      attr_reader :str

      def initialize(str)
        @str = str
      end

      def parsed_numbers
        @parsed_number ||= str.scan(/\d+/).map(&:to_i)
      end

      def number_of_crates
        parsed_numbers[0]
      end

      def from_stack_number
        parsed_numbers[1]
      end

      def from_stack_index
        from_stack_number - 1
      end

      def to_stack_number
        parsed_numbers[2]
      end

      def to_stack_index
        to_stack_number - 1
      end
    end
  end
end
