require 'test/unit'
require_relative '../../../year2022/day4/assignment_sessions'

module Year2022
  module Day4
    class AssignmentSessionsTest < Test::Unit::TestCase
      def setup
        @str1 = '2-4'
        @str2 = '5-7'
        @str3 = '6-6'
        @assignment_sessions1 = Year2022::Day4::AssignmentSessions.new(@str1)
        @assignment_sessions2 = Year2022::Day4::AssignmentSessions.new(@str2)
        @assignment_sessions3 = Year2022::Day4::AssignmentSessions.new(@str3)
      end

      def test_start_session_id
        assert_equal(2, @assignment_sessions1.start_session_id)
        assert_equal(5, @assignment_sessions2.start_session_id)
        assert_equal(6, @assignment_sessions3.start_session_id)
      end

      def test_end_session_id
        assert_equal(4, @assignment_sessions1.end_session_id)
        assert_equal(7, @assignment_sessions2.end_session_id)
        assert_equal(6, @assignment_sessions3.end_session_id)
      end

      def test_contain?
        assert(@assignment_sessions2.contain?(@assignment_sessions3))

        refute(@assignment_sessions1.contain?(@assignment_sessions2))
        refute(@assignment_sessions1.contain?(@assignment_sessions3))
        refute(@assignment_sessions2.contain?(@assignment_sessions1))
        refute(@assignment_sessions3.contain?(@assignment_sessions1))
        refute(@assignment_sessions3.contain?(@assignment_sessions2))
      end
    end
  end
end
