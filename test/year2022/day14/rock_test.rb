require 'test/unit'
require_relative '../../../year2022/day14/rock'

module Year2022
  module Day14
    class RockTest < Test::Unit::TestCase
      def setup
        @rock = Year2022::Day14::Rock.new('123,4')
      end

      def test_initialization
        assert_equal('123,4', @rock.coordinates)
      end

      def test_x
        assert_equal(123, @rock.x)
      end

      def test_y
        assert_equal(4, @rock.y)
      end
    end
  end
end
