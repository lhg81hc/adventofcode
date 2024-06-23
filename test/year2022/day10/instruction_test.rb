require 'test/unit'
require_relative '../../../year2022/day10/instruction'

module Year2022
  module Day10
    class InstructionTest < Test::Unit::TestCase
      class AddxInstructionTest < InstructionTest
        def setup
          @type = 'addx'
          @value = '69'

          @instruction = Year2022::Day10::Instruction.new(@type, @value)
        end

        def test_number_of_required_cycles
          assert_equal(2, @instruction.number_of_required_cycles)
        end

        def test_addx?
          assert(@instruction.addx?)
        end

        def test_noop?
          refute(@instruction.noop?)
        end

        def test_to_s
          assert_equal('addx 69', @instruction.to_s)
        end
      end

      class NoopInstructionTest < InstructionTest
        def setup
          @type = 'noop'
          @value = nil

          @instruction = Year2022::Day10::Instruction.new(@type, @value)
        end

        def test_number_of_required_cycles
          assert_equal(1, @instruction.number_of_required_cycles)
        end

        def test_addx?
          refute(@instruction.addx?)
        end

        def test_noop?
          assert(@instruction.noop?)
        end

        def test_value
          assert_nil(@instruction.value)
        end

        def test_to_s
          assert_equal('noop', @instruction.to_s)
        end
      end

      class InvalidInstructionTest < InstructionTest
        def setup
          @type = 'foo'
          @value = 22

          @instruction = Year2022::Day10::Instruction.new(@type, @value)
        end

        def test_number_of_required_cycles
          assert_raises(ArgumentError) { @instruction.number_of_required_cycles }
        end

        def test_addx?
          refute(@instruction.addx?)
        end

        def test_noop?
          refute(@instruction.noop?)
        end

        def test_value
          assert_equal(22, @instruction.value)
        end

        def test_to_s
          assert_equal('foo 22', @instruction.to_s)
        end
      end
    end
  end
end
