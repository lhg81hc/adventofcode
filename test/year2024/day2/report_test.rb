require 'test/unit'
require_relative '../../../year2024/day2/report'

module Year2024
  module Day2
    class ReportTest < Test::Unit::TestCase
      def setup
        @levels = [7, 6, 4, 2, 1]
        @report = Year2024::Day2::Report.new(@levels)
      end

      def test_initialization
        assert_equal(@report.levels, [7, 6, 4, 2, 1])
      end

      def test_find_bad_level
        @levels = [7, 6, 4, 2, 1]
        @report = Year2024::Day2::Report.new(@levels)
        assert_nil(@report.find_bad_level)

        @levels = [1, 2, 7, 8, 9]
        @report = Year2024::Day2::Report.new(@levels)
        assert_equal(1, @report.find_bad_level)

        @levels = [8, 6, 4, 4, 1]
        @report = Year2024::Day2::Report.new(@levels)
        assert_equal(2, @report.find_bad_level)
      end

      def test_safe?
        [
          [7, 6, 4, 2, 1],
          [1, 3, 6, 7, 9],
        ].each do |levels|
          report = Year2024::Day2::Report.new(levels)
          assert(report.safe?)
        end

        [
          [1, 2, 7, 8, 9],
          [8, 6, 4, 4, 1]
        ].each do |levels|
          report = Year2024::Day2::Report.new(levels)
          refute(report.safe?)
        end
      end

      def test_unsafe?
        levels = [7, 6, 4, 2, 1]
        report = Year2024::Day2::Report.new(levels)

        refute(report.unsafe?)
      end

      def test_safe_without_any_bad_levels_or_with_a_single_bad_level?
        [
          [7, 6, 4, 2, 1],
          [1, 3, 2, 4, 5],
          [8, 6, 4, 4, 1],
          [1, 3, 6, 7, 9],
          [58, 56, 58, 59, 60, 62, 63, 65],
        ].each do |levels|
          report = Year2024::Day2::Report.new(levels)
          assert(report.safe_without_any_bad_levels_or_with_a_single_bad_level?)
        end

        [
          [1, 2, 7, 8, 9],
          [9, 7, 6, 2, 1]
        ].each do |levels|
          report = Year2024::Day2::Report.new(levels)
          refute(report.safe_without_any_bad_levels_or_with_a_single_bad_level?)
        end
      end
    end
  end
end