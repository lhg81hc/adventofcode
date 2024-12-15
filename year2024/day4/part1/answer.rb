require_relative '../word_search'

module Year2024
  module Day4
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          word_search.scan unless word_search.scanned?

          puts "The word XMAS appears #{word_search.search} times"
        end

        def word_search
          @word_search ||= Year2024::Day4::WordSearch.new(filepath)
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
