require_relative './multiplication_instruction'

module Year2024
  module Day3
    class CorruptedMemoryReader
      DO_INSTRUCTION = "do()".freeze
      DONT_INSTRUCTION = "don't()".freeze

      attr_reader :input_path

      def initialize(input_path)
        @input_path = input_path
      end

      def all_multiplication_instructions
        @all_multiplication_instructions ||= multiplication_instructions_by_condition(false)
      end

      def enabled_multiplication_instructions
        @enabled_multiplication_instructions ||= multiplication_instructions_by_condition(true)
      end

      def multiplication_instructions_by_condition(consider_conditional_instructions)
        r = []
        last_conditional_instruction = nil

        File.foreach(input_path) do |line|
          parsed_result = parse_multiplication_instructions_from_line(line, last_conditional_instruction: last_conditional_instruction, consider_conditional_instructions: consider_conditional_instructions)
          last_conditional_instruction = parsed_result[0]
          r += parsed_result[1]
        end

        r
      end

      def parse_multiplication_instructions_from_line(line, last_conditional_instruction:, consider_conditional_instructions:)
        return [] if line.nil? || line.length.zero?

        current_conditional_instruction = last_conditional_instruction
        enabled_multiplication_instructions = []

        last_index = line.length - 1
        start_index = 0
        end_index = 0

        while start_index < last_index
          end_index += 1
          substring = line[start_index..end_index].dup

          if consider_conditional_instructions && (substring.match(/do\(\)/) || substring.match(/don't\(\)/))
            current_conditional_instruction = substring.match(/do\(\)/).to_s if substring.match(/do\(\)/)
            current_conditional_instruction = substring.match(/don't\(\)/).to_s if substring.match(/don't\(\)/)
            start_index = end_index + 1
          end

          if substring.match(/mul\(\d+,\d+\)/)
            multiplication_instruction = substring.match(/mul\(\d+,\d+\)/).to_s

            if consider_conditional_instructions
              if current_conditional_instruction.nil? || current_conditional_instruction == DO_INSTRUCTION
                enabled_multiplication_instructions << Year2024::Day3::MultiplicationInstruction.new(multiplication_instruction)
              end
            else
              enabled_multiplication_instructions << Year2024::Day3::MultiplicationInstruction.new(multiplication_instruction)
            end

            start_index = end_index + 1
          end

          start_index = end_index if end_index == last_index
        end

        [current_conditional_instruction, enabled_multiplication_instructions]
      end
    end
  end
end
