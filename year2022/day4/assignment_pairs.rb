require_relative 'assignment_sessions'

module Year2022
  module Day4
    class AssignmentPairs
      attr_reader :str

      def initialize(str)
        @str = str
      end

      def assignment_sessions
        @str.split(',').map { |assignment_sessions_str| Year2022::Day4::AssignmentSessions.new(assignment_sessions_str) }
      end

      def first_assignment_session
        assignment_sessions[0]
      end

      def second_assignment_session
        assignment_sessions[1]
      end

      def one_range_contain_the_other?
        first_assignment_session.contain?(second_assignment_session) ||
          second_assignment_session.contain?(first_assignment_session)
      end

      def overlapping_pairs?
        first_assignment_session.overlaps?(second_assignment_session)
      end
    end
  end
end
