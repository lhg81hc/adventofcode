require_relative '../pattern'
require_relative '../reflection_finder'

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

              horizontal_reflection_finder = Day13::ReflectionFinder.new(pattern.rows)
              horizontal_reflection_lines = horizontal_reflection_finder.find

              if horizontal_reflection_lines.empty?
                puts "horizontal reflection lines: Not Found"
              else
                horizontal_reflection_lines.each { |line_no| @sum += line_no * 100 }
                puts "horizontal reflection lines: #{horizontal_reflection_lines.join(', ')}"
              end

              vertical_reflection_finder = Day13::ReflectionFinder.new(pattern.cols)
              vertical_reflection_lines = vertical_reflection_finder.find
              if vertical_reflection_lines.empty?
                puts "vertical reflection lines: Not Found"
              else
                puts "vertical reflection lines: #{vertical_reflection_lines.join(', ')}"
                @sum += vertical_reflection_lines.sum
              end
              puts '--------------------'
              puts "\n"
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
