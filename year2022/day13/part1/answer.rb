require_relative '../input_parser'

module Year2022
  module Day11
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          pairs = Year2022::Day13::InputParser.parse(input_path)

          first_pair =  pairs.first
          # first_package = first_pair.first
          # second_package = first_pair.last

          # [[],[[[0],[8,10,2,8],[4]],[[7,7,2,2],10,1,2,[]]],[[[6,1,6,8,10],[8,6,4],[],[],2]]]
          puts first_pair.first_package.items
        end

        def input_path
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
