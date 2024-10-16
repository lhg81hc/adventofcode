require_relative '../cave'
require_relative '../sand'

module Year2022
  module Day14
    module Part2
      class Answer
        def self.run
          new.run
        end

        def run
          cave.scan unless cave.scanned?

          count = 0

          loop do
            sand = cave.pour_sand_with_floor
            count += 1

            break if sand.at_starting_position?
          end

          cave.draw

          puts "The number of units of sand come to rest until the source of the sand becomes blocked: #{count}"
        end

        def input_path
          File.join(File.dirname(__FILE__), '../input.txt')
        end

        def cave
          @cave ||= Year2022::Day14::Cave.new(input_path, floor: true)
        end
      end
    end
  end
end
