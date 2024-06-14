require 'test/unit'
require_relative '../../../year2022/day9/rope_knot'

module Year2022
  module Day9
    class RopeKnotTest < Test::Unit::TestCase
      class ValidInput < RopeKnotTest
        def setup
          @char_index = 10
          @line_index = 5
          @type = :head

          @rope_knot = Year2022::Day9::RopeKnot.new(@char_index, @line_index, @type)
        end

        def test_last_location_and_location_and_location=
          assert_equal([10, 5], @rope_knot.location)
          assert_equal(nil, @rope_knot.last_location)

          @rope_knot.location = [4, 4]
          assert_equal([4, 4], @rope_knot.location)
          assert_equal([10, 5], @rope_knot.last_location)
        end

        def test_type_abbreviation
          assert_equal('H', @rope_knot.type_abbreviation)
        end

        def test_to_s
          assert_equal('H [10,5]', @rope_knot.to_s)
        end
      end

      class InvalidType < RopeKnotTest
        def setup
          @char_index = 1
          @line_index = 1
          @type = :foo

          @rope_knot = Year2022::Day9::RopeKnot.new(@char_index, @line_index, @type)
        end

        def test_last_location_and_location_and_location=
          assert_equal([1, 1], @rope_knot.location)
          assert_equal(nil, @rope_knot.last_location)

          @rope_knot.location = [4, 4]
          assert_equal([4, 4], @rope_knot.location)
          assert_equal([1, 1], @rope_knot.last_location)
        end

        def test_type_abbreviation
          assert_raises(ArgumentError) { @rope_knot.type_abbreviation }
        end

        def test_to_s
          assert_raises(ArgumentError) { @rope_knot.to_s }
        end
      end
    end
  end
end
