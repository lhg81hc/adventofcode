require 'test/unit'
require_relative '../../../year2022/day4/assignment_pairs'
require_relative '../../../year2022/day4/assignment_sessions'

module Year2022
  module Day4
    class AssignmentSessionsTest < Test::Unit::TestCase
      def setup
        @str1 = '2-3,4-5'
        @str2 = '6-6,4-6'
        @assignment_pairs1 = Year2022::Day4::AssignmentPairs.new(@str1)
        @assignment_pairs2 = Year2022::Day4::AssignmentPairs.new(@str2)
      end

      def test_assignment_sessions
        assert_equal(2, @assignment_pairs1.assignment_sessions.length)
        assert_equal(2, @assignment_pairs2.assignment_sessions.length)
      end

      def test_first_assignment_session
        assert(@assignment_pairs1.first_assignment_session.is_a?(Year2022::Day4::AssignmentSessions))
        assert(@assignment_pairs2.first_assignment_session.is_a?(Year2022::Day4::AssignmentSessions))
      end

      def test_second_assignment_session
        assert(@assignment_pairs1.second_assignment_session.is_a?(Year2022::Day4::AssignmentSessions))
        assert(@assignment_pairs2.second_assignment_session.is_a?(Year2022::Day4::AssignmentSessions))
      end

      def test_one_range_contain_the_other?
        refute(@assignment_pairs1.one_range_contain_the_other?)
        assert(@assignment_pairs2.one_range_contain_the_other?)
      end
    end
  end
end
