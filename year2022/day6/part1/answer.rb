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
          puts Year2022::Day6::Subroutine.new.find_marker_position(datastream).to_s
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
