require 'test/unit'
require_relative '../../../year2022/day14/path_of_rock'

module Year2022
  module Day14
    class PathOfRockTest < Test::Unit::TestCase
      def setup
        @path_of_rock = Year2022::Day14::PathOfRock.new('525,75 -> 525,77 -> 517,77 -> 517,83 -> 532,83 -> 532,77 -> 531,77 -> 531,75')
      end

      def test_initialization
        assert_equal('525,75 -> 525,77 -> 517,77 -> 517,83 -> 532,83 -> 532,77 -> 531,77 -> 531,75', @path_of_rock.str)
      end

      def test_rocks
        rocks = @path_of_rock.rocks

        assert_equal(8, rocks.length)
        assert_equal('525,75', rocks[0].coordinates)
        assert_equal('517,83', rocks[3].coordinates)
        assert_equal('531,75', rocks[7].coordinates)
      end

      def test_lines_of_rock
        lines_of_rock = @path_of_rock.lines_of_rock
        assert_equal(7, lines_of_rock.length)

        first_line_of_rock = lines_of_rock.first
        assert_equal('525,75', first_line_of_rock.first_rock.coordinates)
        assert_equal('525,77', first_line_of_rock.last_rock.coordinates)

        last_line_of_rock = lines_of_rock.last
        assert_equal('531,77', last_line_of_rock.first_rock.coordinates)
        assert_equal('531,75', last_line_of_rock.last_rock.coordinates)
      end
    end
  end
end
