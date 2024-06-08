require 'test/unit'
require_relative '../../../year2022/day6/subroutine'

module Year2022
  module Day6
    class SubroutineTest < Test::Unit::TestCase
      def setup
        @datastream1 = 'mjqjpqmgbljsphdztnvjfqwrcgsmlb'
        @datastream2 = 'bvwbjplbgvbhsrlpgdmjqwftvncz'
        @datastream3 = 'nppdvjthqldpwncqszvftbrmjlhg'
        @datastream4 = 'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg'
        @datastream5 = 'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw'
        @datastream6 = 'zcfzawbdqerljgfkmnopg'

        @subroutine = Year2022::Day6::Subroutine.new
      end

      def test_find_marker_position
        assert_equal(7, @subroutine.find_marker_position(datastream: @datastream1, num_of_distinct_chars: 4))
        assert_equal(5, @subroutine.find_marker_position(datastream: @datastream2, num_of_distinct_chars: 4))
        assert_equal(6, @subroutine.find_marker_position(datastream: @datastream3, num_of_distinct_chars: 4))
        assert_equal(10, @subroutine.find_marker_position(datastream: @datastream4, num_of_distinct_chars: 4))
        assert_equal(11, @subroutine.find_marker_position(datastream: @datastream5, num_of_distinct_chars: 4))
        assert_equal(11, @subroutine.find_marker_position(datastream: @datastream5, num_of_distinct_chars: 4))
        assert_equal(17, @subroutine.find_marker_position(datastream: @datastream6, num_of_distinct_chars: 14))
      end

      def test_string_has_duplicate?
        refute(@subroutine.string_has_duplicate?('abcde'))
        refute(@subroutine.string_has_duplicate?('wzlrfnpq'))
        assert(@subroutine.string_has_duplicate?('mjqj'))
        assert(@subroutine.string_has_duplicate?('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw'))
      end
    end
  end
end
