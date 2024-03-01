require_relative '../initialization_sequence'
require_relative '../hashing_ulti'

module Day15
  module Part1
    class Answer
      include HashingUtil

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
          @sum += hash(step)
        end

        puts "Run the HASH algorithm on each step in the initialization sequence. The sum of the results: #{sum}"
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
