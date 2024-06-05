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

        @subroutine = Year2022::Day6::Subroutine.new
      end

      def test_find_marker_position
        assert_equal(7, @subroutine.find_marker_position(@datastream1))
        assert_equal(5, @subroutine.find_marker_position(@datastream2))
        assert_equal(6, @subroutine.find_marker_position(@datastream3))
        assert_equal(10, @subroutine.find_marker_position(@datastream4))
        assert_equal(11, @subroutine.find_marker_position(@datastream5))
      end
    end
  end
end
