require_relative './multiplication_instruction'

module Year2024
  module Day3
    class CorruptedMemoryReader
      attr_reader :input_path

      def initialize(input_path)
        @input_path = input_path
      end

      def sum
        multiplication_instructions.inject(0) do |r, multiplication_instruction|
          r += multiplication_instruction.result
          r
        end
      end

      def multiplication_instructions
        @multiplication_instructions ||=
          File.foreach(input_path).inject([]) do |r, line|
            line.scan(Year2024::Day3::MultiplicationInstruction::RE_PATTERN).each do |multiplication_instruction_str|
              r << Year2024::Day3::MultiplicationInstruction.new(multiplication_instruction_str)
            end

            r
          end
      end
    end
  end
end
