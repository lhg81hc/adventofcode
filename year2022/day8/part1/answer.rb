require_relative '../visible_tree_counter'
require_relative '../input_parser'

module Year2022
  module Day8
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          puts "The number of trees that are visible from outside the grid #{Year2022::Day8::VisibleTreeCounter.new(grid).count}"
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
