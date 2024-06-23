require 'test/unit'
require_relative '../../../year2022/day10/cathode_ray_tube_screen'
require_relative '../../../year2022/day10/instruction'

module Year2022
  module Day10
    class CathodeRayTubeScreenTest < Test::Unit::TestCase
      def setup
        @ctr = CathodeRayTubeScreen.new
      end

      def test_cycle_to_line_index
        assert_equal(2, @ctr.cycle_to_line_index(87))
        assert_equal(1, @ctr.cycle_to_line_index(65))
        assert_equal(0, @ctr.cycle_to_line_index(22))
        assert_equal(5, @ctr.cycle_to_line_index(240))
      end

      def test_cycle_to_char_index
        assert_equal(6, @ctr.cycle_to_char_index(87))
        assert_equal(24, @ctr.cycle_to_char_index(65))
        assert_equal(39, @ctr.cycle_to_char_index(40))
        assert_equal(39, @ctr.cycle_to_char_index(240))
      end

      def test_draw
        assert_equal('........................................', @ctr.pixel_map[0].join)
        assert_equal([0, 1, 2], @ctr.sprite_pixel_horizontal_positions)

        @ctr.draw(1)
        assert_equal('#.......................................', @ctr.pixel_map[0].join)

        @ctr.draw(2)
        assert_equal('##......................................', @ctr.pixel_map[0].join)

        @ctr.update_sprite_position(Year2022::Day10::Instruction.new('addx', 15))
        assert_equal([15, 16, 17], @ctr.sprite_pixel_horizontal_positions)

        @ctr.draw(3)
        assert_equal('##......................................', @ctr.pixel_map[0].join)

        @ctr.draw(17)
        assert_equal('##..............#.......................', @ctr.pixel_map[0].join)
      end

      def test_update_sprite_position
        assert_equal([0, 1, 2], @ctr.sprite_pixel_horizontal_positions)

        @ctr.update_sprite_position(Year2022::Day10::Instruction.new('addx', 11))
        assert_equal([11, 12, 13], @ctr.sprite_pixel_horizontal_positions)
      end
    end
  end
end
