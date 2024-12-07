require_relative '../list_parser'
require_relative '../distance_finder'

module Year2024
  module Day1
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          puts "The total distance between 2 lists: #{distance_finder.distance}"
        end

        def list_parser
          @list_parser ||= Year2024::Day1::ListParser.new(filepath)
        end

        def distance_finder
          @distance_finder ||= Year2024::Day1::DistanceFinder.new(*list_parser.parse)
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
