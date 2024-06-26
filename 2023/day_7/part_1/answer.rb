require_relative '../hand'
require_relative '../hand_value_comparison'

module Day7
  module Part1
    class Answer
      INPUT_FILE = '../input.txt'

      attr_reader :total_winnings, :hands

      def initialize
        @total_winnings = 0
        @hands = []
      end

      def self.run
        new.run
      end

      def run
        build_hands
        sort_hands!

        @total_winnings = hands.each_with_index.inject(0) do |count, (hand, idx)|
          count += hand.bid.to_i * (idx + 1)
          count
        end

        puts "Total winnings: #{@total_winnings}"
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end

      private

      def build_hands
        File.foreach(input_path) { |line| @hands << Day7::Hand.new(*line.split) }
      end

      def sort_hands!
        @hands.sort! { |a, b| Day7::HandValueComparison.compare(a.hand_value, b.hand_value) }
      end
    end
  end
end
