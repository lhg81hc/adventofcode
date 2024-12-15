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

      def test_all_multiplication_instructions
        instructions = @memory_reader.all_multiplication_instructions
        assert_equal(instructions.length, 4)

        first_instruction = instructions[0]
        second_instruction = instructions[1]
        third_instruction = instructions[2]
        last_instruction = instructions[3]

        assert_equal(first_instruction.str, 'mul(2,4)')
        assert_equal(second_instruction.str, 'mul(5,5)')
        assert_equal(third_instruction.str, 'mul(11,8)')
        assert_equal(last_instruction.str, 'mul(8,5)')
      end

      def test_enabled_multiplication_instructions
        instructions = @memory_reader.enabled_multiplication_instructions
        assert_equal(instructions.length, 2)

        first_instruction = instructions[0]
        last_instruction = instructions[1]

        assert_equal(first_instruction.str, 'mul(2,4)')
        assert_equal(last_instruction.str, 'mul(8,5)')
      end
    end
  end
end
