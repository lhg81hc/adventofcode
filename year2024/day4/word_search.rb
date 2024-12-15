module Year2024
  module Day4
    class WordSearch
      TARGET = 'XMAS'.freeze
      REVERSE_TARGET = 'SAMX'.freeze

      attr_reader :input_path, :letters

      def initialize(input_path)
        @input_path = input_path
        @scanned = false
        @letters = []
      end

      def search
        scan unless scanned?

        letters.each.with_index.inject(0) do |count, (row, row_idx)|
          row.each.with_index { |_c, char_idx| count += num_of_xmas_appearance_around_a_point(char_idx, row_idx) }
          count
        end
      end

      def scanned?
        @scanned
      end

      def height
        scanned? ? @letters.length : 0
      end

      def width
        scanned? ? @letters.first.length : 0
      end

      def scan
        File.foreach(input_path).with_index do |line, line_idx|
          @letters[line_idx] = line.strip.split('')
        end

        @scanned = true
      end

      private

      def num_of_xmas_appearance_around_a_point(char_idx, row_idx)
        potential_xmas_characters_coordinates(char_idx, row_idx).inject(0) do |count, coordinates|
          word = coordinates.map { |coordinate| letters[coordinate[1]][coordinate[0]] }.join
          count += 1 if [TARGET, REVERSE_TARGET].include?(word)
          count
        end
      end

      def potential_xmas_characters_coordinates(char_idx, row_idx)
        %i[
          forward_coordinates
          downward_coordinates
          left_backward_diagonal_coordinates
          right_forward_diagonal_coordinates
        ].each_with_object([]) do |me, r|
          coordinates = send(me, char_idx, row_idx)
          r << coordinates unless coordinates.empty?
          r
        end
      end

      def forward_coordinates(char_idx, row_idx)
        return [] if char_idx + 3 > width - 1

        [[char_idx, row_idx], [char_idx + 1, row_idx], [char_idx + 2, row_idx], [char_idx + 3, row_idx]]
      end

      def downward_coordinates(char_idx, row_idx)
        return [] if row_idx + 3 > height - 1

        [[char_idx, row_idx], [char_idx, row_idx + 1], [char_idx, row_idx + 2], [char_idx, row_idx + 3]]
      end

      def left_backward_diagonal_coordinates(char_idx, row_idx)
        return [] if row_idx + 3 > height - 1 || (char_idx - 3).negative?

        [[char_idx, row_idx], [char_idx - 1, row_idx + 1], [char_idx - 2, row_idx + 2], [char_idx - 3, row_idx + 3]]
      end

      def right_forward_diagonal_coordinates(char_idx, row_idx)
        return [] if row_idx + 3 > height - 1 || char_idx + 3 > width - 1

        [[char_idx, row_idx], [char_idx + 1, row_idx + 1], [char_idx + 2, row_idx + 2], [char_idx + 3, row_idx + 3]]
      end
    end
  end
end
