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

      def test_safe?
        @levels = [7, 6, 4, 2, 1]
        @report = Year2024::Day2::Report.new(@levels)
        assert(@report.safe?)

        @levels = [1, 3, 6, 7, 9]
        @report = Year2024::Day2::Report.new(@levels)
        assert(@report.safe?)

        @levels = [1, 2, 7, 8, 9]
        @report = Year2024::Day2::Report.new(@levels)
        refute(@report.safe?)

        @levels = [8, 6, 4, 4, 1]
        @report = Year2024::Day2::Report.new(@levels)
        refute(@report.safe?)
      end

      def test_unsafe?
        @levels = [7, 6, 4, 2, 1]
        @report = Year2024::Day2::Report.new(@levels)

        refute(@report.unsafe?)
      end
    end
  end
end