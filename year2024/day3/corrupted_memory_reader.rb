require_relative './multiplication_instruction'
require_relative './conditional_instruction'

module Year2024
  module Day3
    class CorruptedMemoryReader
      DO_INSTRUCTION = 'do()'.freeze
      DONT_INSTRUCTION = "don't()".freeze

      attr_reader :input_path

      def initialize(input_path)
        @input_path = input_path
      end

      def all_multiplication_instructions
        @all_multiplication_instructions ||=
          instructions.select { |i| i.is_a?(Year2024::Day3::MultiplicationInstruction) }
      end

      def enabled_multiplication_instructions
        @enabled_multiplication_instructions ||=
          begin
            last_conditional_instruction = nil

            instructions.each_with_object([]) do |i, r|
              r << i if i.is_a?(Year2024::Day3::MultiplicationInstruction) &&
                        (last_conditional_instruction.nil? || last_conditional_instruction.do_instruction?)
              last_conditional_instruction = i if i.is_a?(Year2024::Day3::ConditionalInstruction)
              r
            end
          end
      end

      def instructions
        @instructions ||=
          File.foreach(input_path).inject([]) do |r, line|
            r += parse_line(line)
            r
          end
      end

      def parse_line(line)
        line.scan(/do\(\)|don't\(\)|mul\(\d+,\d+\)/).each_with_object([]) do |str, r|
          if [Year2024::Day3::ConditionalInstruction::DONT_INSTRUCTION,
              Year2024::Day3::ConditionalInstruction::DO_INSTRUCTION].include?(str)
            r << Year2024::Day3::ConditionalInstruction.new(str)
          elsif str.match(Year2024::Day3::MultiplicationInstruction::RE_PATTERN)
            r << Year2024::Day3::MultiplicationInstruction.new(str)
          end

          r
        end
      end
    end
  end
end
