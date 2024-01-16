require_relative 'scratchcard_reader'

module Day4
  module Part1
    class Answer
      attr_reader :sum


      def initialize
        @sum = 0
      end

      def self.run
        new.run
      end

      def run
        input_file.each_line do |line|
          scratchcard_reader = Day4::Part1::ScratchcardReader.read(line)
          @sum += scratchcard_reader.card_point
        end

        puts "Total points: #{sum}"
      end

      def input_file
        @input_file ||= File.open(input_path)
      end

      def input_path
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
