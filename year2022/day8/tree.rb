module Year2022
  module Day8
    class Tree
      attr_reader :char_index, :line_index, :height

      def initialize(char_index, line_index, height)
        @char_index = char_index
        @line_index = line_index
        @height = height
      end

      def location
        [char_index, line_index]
      end

      def to_s
        location.join(',')
      end

      def on_top_edge?
        line_index.zero?
      end

      def on_left_edge?
        char_index.zero?
      end

      def on_bottom_edge?
        @on_bottom_edge
      end

      def on_right_edge?
        @on_right_edge
      end

      def on_bottom_edge=(val)
        @on_bottom_edge = val
      end

      def on_right_edge=(val)
        @on_right_edge = val
      end

      def around_the_edge?
        on_top_edge? || on_left_edge? || on_bottom_edge? || on_right_edge?
      end
    end
  end
end
