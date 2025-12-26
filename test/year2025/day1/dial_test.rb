require 'test/unit'
require_relative '../../../year2025/day1/dial'
require_relative '../../../year2025/day1/rotation'

module Year2025
  module Day1
    class DialTest < Test::Unit::TestCase
      def setup
        @dial = Year2025::Day1::Dial.new
      end

      def test_initialization
        assert_equal(@dial.current_position, 50)
        assert_equal(@dial.password, 0)
      end

      def test_rotation_and_password
        rotation_map =
          {
            'L68' => 82,
            'L30' => 52,
            'R48' => 0,
            'L5' => 95,
            'R60' => 55,
            'L55' => 0,
            'L1' => 99,
            'L99' => 0,
            'R14' => 14,
            'L82' => 32,
          }

        rotation_map.each do |rotation_instruction, new_position|
          rotation = Year2025::Day1::Rotation.new(rotation_instruction)
          @dial.rotate(rotation)
          assert_equal(@dial.current_position, new_position)
        end

        assert_equal(@dial.password, 3)
        assert_equal(@dial.password_0x434C49434B, 6)
      end
    end
  end
end