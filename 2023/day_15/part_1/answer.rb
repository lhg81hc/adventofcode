require_relative '../initialization_sequence'
require_relative '../hashing_service'

module Day15
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
        initialization_sequence.steps.each do |step|
          hashing_service = Day15::HashingService.new(step)
          @sum += hashing_service.hash
        end

        puts sum
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
