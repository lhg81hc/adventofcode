require_relative '../pattern'

module Day13
  module Part1
    class Answer
      INPUT_FILE = '../input.txt'

      attr_reader :sum

      def initialize
        @sum = 0
      end

      def self.run
        new.run
      end

      def run
        pattern_lines = []

        lines.each.with_index do |line, idx|
          if line.empty? || idx == last_line_idx
            unless pattern_lines.empty?
              pattern = Day13::Pattern.new(pattern_lines)
              puts pattern.rows.first.join
              puts '--------------------'
              puts "\n"
            end

            pattern_lines.clear
          else
            pattern_lines << line
          end
        end
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end

      def lines
        @lines ||=
          File.open(input_path).inject([]) do |r, line|
            r << line.strip
            r
          end
      end

      def total_lines
        @total_lines ||= lines.length
      end

      def last_line_idx
        @last_line_idx ||= total_lines - 1
      end
    end
  end
end
