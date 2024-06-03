require_relative 'assignment_sessions'

module Year2022
  module Day4
    class AssignmentPairs
      attr_reader :str

      def initialize(str)
        @str = str
      end

      def session_assignments
        @str.split(',').map { |assignment_sessions_str| Year2022::Day4::AssignmentSessions.new(assignment_sessions_str) }
      end

      def first_session_assignment
        session_assignments[0]
      end

      def second_session_assignment
        session_assignments[1]
      end

      def one_range_contain_the_other?
        first_session_assignment.contain?(second_session_assignment) ||
          second_session_assignment.contain?(first_session_assignment)
      end
    end
  end
end
