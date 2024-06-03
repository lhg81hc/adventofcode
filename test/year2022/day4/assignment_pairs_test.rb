require 'test/unit'
require_relative '../../../year2022/day4/assignment_pairs'
require_relative '../../../year2022/day4/assignment_pairs'

module Year2022
  module Day4
    class AssignmentSessionsTest < Test::Unit::TestCase
      def setup
        @str1 = '2-3,4-5'
        @str2 = '6-6,4-6'
        @assignment_pairs1 = Year2022::Day4::AssignmentPairs.new(@str1)
        @assignment_pairs2 = Year2022::Day4::AssignmentPairs.new(@str2)
      end

      def test_session_assignments
        assert_equal(2, @assignment_pairs1.session_assignments.length)
        assert_equal(2, @assignment_pairs2.session_assignments.length)
      end

      def test_first_session_assignment
        assert(@assignment_pairs1.first_session_assignment.is_a?(Year2022::Day4::AssignmentSessions))
        assert(@assignment_pairs2.first_session_assignment.is_a?(Year2022::Day4::AssignmentSessions))
      end

      def test_second_session_assignment
        assert(@assignment_pairs1.second_session_assignment.is_a?(Year2022::Day4::AssignmentSessions))
        assert(@assignment_pairs2.second_session_assignment.is_a?(Year2022::Day4::AssignmentSessions))
      end

      def test_one_range_contain_the_other?
        refute(@assignment_pairs1.one_range_contain_the_other?)
        assert(@assignment_pairs2.one_range_contain_the_other?)
      end
    end
  end
end
