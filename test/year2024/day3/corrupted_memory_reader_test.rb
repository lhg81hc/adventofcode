require 'test/unit'
require_relative '../../../year2024/day3/corrupted_memory_reader'
require_relative '../../../year2024/day3/multiplication_instruction'

module Year2024
  module Day2
    class CorruptedMemoryReaderTest < Test::Unit::TestCase
      def setup
        @input_path = File.join(File.dirname(__FILE__), './input.txt')
        @memory_reader = Year2024::Day3::CorruptedMemoryReader.new(@input_path)
      end

      def test_initialization
        assert_equal(@memory_reader.input_path.to_s, File.join(File.dirname(__FILE__), './input.txt'))
      end

      def test_multiplication_instructions
        multiplication_instructions = @memory_reader.multiplication_instructions
        assert_equal(multiplication_instructions.length, 4)

        first_instruction = multiplication_instructions[0]
        last_instruction = multiplication_instructions[3]

        assert(first_instruction.is_a?(Year2024::Day3::MultiplicationInstruction))
        assert_equal(first_instruction.str, 'mul(2,4)')

        assert(last_instruction.is_a?(Year2024::Day3::MultiplicationInstruction))
        assert_equal(last_instruction.str, 'mul(8,5)')
      end

      def test_sum
        assert_equal(@memory_reader.sum, 161)
      end
    end
  end
end
