require_relative '../second_strategy'

module Day2
  module Part2
    class Answer
      def self.run
        new.run
      end

      def run
        total_score =
          File.foreach(filepath).inject(0) do |r, line|
            round = Year2022::Day2::SecondStrategy.new(line.strip)
            puts "Opponent: #{round.opponent_selected_shape}, Expected Outcome: #{round.outcome_to_s}, You: #{round.self_selected_shape}"

            r += round.score
            r
          end

        puts "The total score be if everything goes exactly according to your strategy guide: #{total_score}"
      end

      def filepath
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
