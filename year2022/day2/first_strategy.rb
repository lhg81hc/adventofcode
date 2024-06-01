require_relative 'round'

module Year2022
  module Day2
    class FirstStrategy < Round
      OPPONENT_OPTIONS = { 'A' => :rock, 'B' => :paper, 'C' => :scissors }
      SELF_OPTIONS = { 'X' => :rock, 'Y' => :paper, 'Z' => :scissors }

      def opponent_selected_char
        @str[0]
      end

      def self_selected_char
        @str[-1]
      end

      def self_selected_shape
        SELF_OPTIONS[self_selected_char]
      end

      def opponent_selected_shape
        OPPONENT_OPTIONS[opponent_selected_char]
      end
    end
  end
end
