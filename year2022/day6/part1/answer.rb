require_relative '../subroutine'

module Year2022
  module Day6
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          datastream = File.open(filepath).read.chomp
          marker_position = Year2022::Day6::Subroutine.new.first_marker_position(datastream: datastream, num_of_distinct_chars: 4)

          puts "The number of characters need to be processed before the first start-of-packet marker is detected: #{marker_position ? marker_position : 'Not Found'}"
        end

        def input_parser
          @input_parser ||= Year2022::Day5::InputParser.parse(filepath)
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
