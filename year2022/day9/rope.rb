require_relative 'step_utils'

module Year2022
  module Day9
    class Rope
      include StepUtils

      attr_accessor :head, :tail

      def initialize(head, tail)
        @head = head
        @tail = tail
      end

      def length
        if two_ends_overlapping?
          0
        elsif horizontal_diff_between_head_and_tail > vertical_diff_between_head_and_tail
          horizontal_diff_between_head_and_tail
        else
          vertical_diff_between_head_and_tail
        end
      end

      def head_covers_tail?
        head.char_index == tail.char_index && head.line_index == tail.line_index
      end

      alias :two_ends_overlapping? :head_covers_tail?

      def two_ends_touching?
        length <= 1
      end

      def horizontal_diff_between_head_and_tail
        (head.char_index - tail.char_index).abs
      end

      def vertical_diff_between_head_and_tail
        (tail.line_index - head.line_index).abs
      end
    end
  end
end
