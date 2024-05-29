require_relative '../round'

module Day2
  module Part1
    class Answer
      def self.run
        new.run
      end

      def run
        total_score =
          File.foreach(filepath).inject(0) do |r, line|
            round = Day2::Round.new(line.strip)
            puts round.outcome_to_s

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
