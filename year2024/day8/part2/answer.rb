require_relative '../diagram'

module Year2024
  module Day7
    module Part2
      class Answer
        def self.run
          new.run
        end

        def run
          locations = Set.new([])

          diagram.all_antenna_frequencies.each do |frequency|
            locations.merge(@diagram.find_antinode_locations_by_frequency(frequency, consider_resonant_harmonics_effect: true))
          end

          puts "The number of unique locations within the bounds of the map contain an antinode is #{locations.length}"
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
