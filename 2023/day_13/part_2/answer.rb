require_relative '../pattern'
require_relative '../smudge_finder'

module Day13
  module Part2
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

              horizontal_smudge_finder = Day13::SmudgeFinder.new(pattern.rows)
              horizontal_reflection_line = horizontal_smudge_finder.find_reflection

              if horizontal_reflection_line.nil?
                vertical_smudge_finder = Day13::SmudgeFinder.new(pattern.cols)
                vertical_reflection_line = vertical_smudge_finder.find_reflection

                if vertical_reflection_line.nil?
                  puts "vertical reflection line: Not Found"
                else
                  puts "vertical reflection line: #{vertical_reflection_line}"
                  @sum += vertical_reflection_line
                end
                puts '--------------------'
                puts "\n"
              else
                @sum += horizontal_reflection_line * 100
                puts "horizontal reflection line: #{horizontal_reflection_line}"
                puts '--------------------'
                puts "\n"
              end
            end

            pattern_lines.clear
          else
            pattern_lines << line
          end
        end

        puts "Sum of all of your notes: #{sum}"
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
