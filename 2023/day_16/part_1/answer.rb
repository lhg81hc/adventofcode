require_relative '../contraption'

module Day16
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
        contraption.grid.each do |grid_row|
          puts grid_row.map(&:char).join
        end
      end

      def contraption
        @contraption ||= Day16::Contraption.new(input_path)
      end

      # def lines
      #   @lines ||=
      #     File.open(input_path).inject([]) do |r, line|
      #       r << line.strip
      #       r
      #     end
      # end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end
    end
  end
end
