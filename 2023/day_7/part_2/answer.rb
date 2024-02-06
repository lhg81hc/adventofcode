require_relative '../hand'
require_relative '../hand_comparison'
require_relative '../card_combination'

module Day7
  module Part2
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
          puts "#{hand.str}"
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
        @hands.sort! { |a, b| Day7::HandComparison.compare(a, b, true) }
      end
    end
  end
end
