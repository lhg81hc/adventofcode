# frozen_string_literal: true

require_relative '../first_strategy'

module Day2
  module Part1
    class Answer
      def self.run
        new.run
      end

      def run
        total_score =
          File.foreach(filepath).reduce(0) do |r, line|
            round = Year2022::Day2::FirstStrategy.new(line.strip)
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
