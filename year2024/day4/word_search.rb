module Year2024
  module Day4
    class WordSearch
      TARGET = 'XMAS'.freeze
      REVERSE_TARGET = 'SAMX'.freeze

      attr_reader :input_path, :letters, :width, :height

      def initialize(input_path)
        @input_path = input_path
        @scanned = false
        @width = 0
        @height = 0
        @letters = []
      end

      def search
        scan unless scanned?
        count = 0

        letters.each.with_index do |row, row_idx|
          row.each.with_index do |_char, char_idx|
            chars_coordinates(char_idx, row_idx).each do |coordinates|
              word = coordinates.map { |coordinate| letters[coordinate[1]][coordinate[0]] }.join
              count += 1 if [TARGET, REVERSE_TARGET].include?(word)
            end
          end
        end

        count
      end

      def scanned?
        @scanned
      end

      def scan
        File.foreach(input_path).with_index do |line, line_idx|
          @letters[line_idx] = line.strip.split('')
        end

        @height = @letters.length
        @width = @letters.first.length
        @scanned = true
      end

      def chars_coordinates(char_idx, row_idx)
        r = []

        if row_idx + 3 <= height - 1
          r << [[char_idx, row_idx], [char_idx, row_idx + 1], [char_idx, row_idx + 2], [char_idx, row_idx + 3]]
        end

        if row_idx + 3 <= height - 1 && char_idx + 3 <= width - 1
          r << [[char_idx, row_idx], [char_idx + 1, row_idx + 1], [char_idx + 2, row_idx + 2], [char_idx + 3, row_idx + 3]]
        end

        if char_idx + 3 <= width - 1
          r << [[char_idx, row_idx], [char_idx + 1, row_idx], [char_idx + 2, row_idx], [char_idx + 3, row_idx]]
        end

        if row_idx + 3 <= height - 1 && char_idx - 3 >= 0
          r << [[char_idx, row_idx], [char_idx - 1, row_idx + 1], [char_idx - 2, row_idx + 2], [char_idx - 3, row_idx + 3]]
        end

        r
      end
    end
  end
end
