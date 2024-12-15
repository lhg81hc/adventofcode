module Year2024
  module Day4
    class WordSearch
      XMAS = 'XMAS'.freeze
      SAMX = 'SAMX'.freeze
      SAM = 'SAM'.freeze
      MAS = 'MAS'.freeze
      CENTER_OF_X_MAS = 'A'.freeze

      attr_reader :input_path, :letters

      def initialize(input_path)
        @input_path = input_path
        @scanned = false
        @letters = []
      end

      def search_xmas
        scan unless scanned?

        letters.each.with_index.inject(0) do |count, (row, row_idx)|
          row.each.with_index { |_c, char_idx| count += num_of_xmas_appearance_around_a_point(char_idx, row_idx) }
          count
        end
      end

      def search_x_mas
        scan unless scanned?

        letters.each.with_index.inject(0) do |count, (row, row_idx)|
          row.each.with_index do |char, char_idx|
            next unless char == CENTER_OF_X_MAS

            count += 1 if x_mas_center?(char_idx, row_idx)
          end

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
          count += 1 if [XMAS, SAMX].include?(word)
          count
        end
      end

      def x_mas_center?(char_idx, row_idx)
        words =
          mas_diagonal_coordinates(char_idx, row_idx).map do |coordinates|
            coordinates.map { |coordinate| letters[coordinate[1]][coordinate[0]] }.join
          end

        !words.empty? && words.all? { |word| [MAS, SAM].include?(word) }
      end

      def potential_xmas_characters_coordinates(char_idx, row_idx)
        %i[
          xmas_forward_coordinates
          xmas_downward_coordinates
          xmas_right_diagonal_coordinates
          xmas_left_diagonal_coordinates
        ].each_with_object([]) do |me, r|
          coordinates = send(me, char_idx, row_idx)
          r << coordinates unless coordinates.empty?
          r
        end
      end

      def xmas_forward_coordinates(char_idx, row_idx)
        return [] if char_idx + 3 > width - 1

        [[char_idx, row_idx], [char_idx + 1, row_idx], [char_idx + 2, row_idx], [char_idx + 3, row_idx]]
      end

      def xmas_downward_coordinates(char_idx, row_idx)
        return [] if row_idx + 3 > height - 1

        [[char_idx, row_idx], [char_idx, row_idx + 1], [char_idx, row_idx + 2], [char_idx, row_idx + 3]]
      end

      def xmas_right_diagonal_coordinates(char_idx, row_idx)
        return [] if row_idx + 3 > height - 1 || (char_idx - 3).negative?

        [[char_idx, row_idx], [char_idx - 1, row_idx + 1], [char_idx - 2, row_idx + 2], [char_idx - 3, row_idx + 3]]
      end

      def xmas_left_diagonal_coordinates(char_idx, row_idx)
        return [] if row_idx + 3 > height - 1 || char_idx + 3 > width - 1

        [[char_idx, row_idx], [char_idx + 1, row_idx + 1], [char_idx + 2, row_idx + 2], [char_idx + 3, row_idx + 3]]
      end

      def mas_diagonal_coordinates(char_idx, row_idx)
        return [] if (char_idx - 1).negative? || (row_idx - 1).negative?
        return [] if char_idx + 1 > width - 1 || row_idx + 1 > height - 1

        [
          [[char_idx - 1, row_idx - 1], [char_idx, row_idx], [char_idx + 1, row_idx + 1]],
          [[char_idx - 1, row_idx + 1], [char_idx, row_idx], [char_idx + 1, row_idx - 1]]
        ]
      end
    end
  end
end
