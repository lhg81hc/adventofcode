require_relative '../input_parser'

module Year2022
  module Day8
    module Part2
      class Answer
        def self.run
          new.run
        end

        def run
          puts "The highest scenic score possible for any tree: #{grid.highest_scenic_score}"
        end

        def grid
          @gird = Year2022::Day8::InputParser.parse(filepath)
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
