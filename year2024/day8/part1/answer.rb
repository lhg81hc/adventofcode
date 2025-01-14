require_relative '../diagram'

module Year2024
  module Day7
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          locations =
            diagram.all_antenna_frequencies.inject({}) do |r, frequency|
              r.merge!(@diagram.find_antinode_locations_by_frequency(frequency))
              r
            end

          p locations
          p locations.keys.count
        end

        def diagram
          @diagram ||= Year2024::Day8::Diagram.new(filepath)
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
