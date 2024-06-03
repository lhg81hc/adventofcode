module Year2022
  module Day4
    class AssignmentSessions
      attr_reader :range_str

      def initialize(range_str)
        @range_str = range_str
      end

      def session_ids
        @session_ids ||= @range_str.split('-').map(&:to_i).sort
      end

      def start_session_id
        session_ids[0]
      end

      def end_session_id
        session_ids[1]
      end

      def contain?(another_assignment_sessions)
        start_session_id <= another_assignment_sessions.start_session_id &&
          end_session_id >= another_assignment_sessions.end_session_id
      end

      def include?(session_id)
        start_session_id <= session_id && session_id <= end_session_id
      end

      def overlaps?(another_assignment_sessions)
        include?(another_assignment_sessions.start_session_id) ||
          another_assignment_sessions.include?(start_session_id)
      end
    end
  end
end
