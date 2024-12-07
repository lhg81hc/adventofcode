require_relative '../similarity_score_finder'
require_relative '../list_parser'

module Year2024
  module Day1
    module Part2
      class Answer
        def self.run
          new.run
        end

        def run
          puts "The similarity score between 2 lists: #{similarity_score_finder.score}"
        end

        def list_parser
          @list_parser ||= Year2024::Day1::ListParser.new(filepath)
        end

        def similarity_score_finder
          @similarity_score_finder ||= Year2024::Day1::SimilarityScoreFinder.new(*list_parser.parse)
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
