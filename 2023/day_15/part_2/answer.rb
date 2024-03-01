require_relative '../initialization_sequence'
require_relative '../initialization_sequence_executor'

module Day15
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
        boxes = Day15::InitializationSequenceExecutor.new(initialization_sequence).execute
        boxes.each do |box|
          box.lenses.each.with_index do |lens, lens_idx|
            focusing_power = (box.box_no + 1) * (lens_idx + 1) * lens.focal_length
            @sum += focusing_power
          end
        end

        puts "the focusing power of the resulting lens configuration: #{sum}"
      end

      def initialization_sequence
        @initialization_sequence ||= Day15::InitializationSequence.new(lines.first)
      end

      def lines
        @lines ||=
          File.open(input_path).inject([]) do |r, line|
            r << line.strip
            r
          end
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end
    end
  end
end
