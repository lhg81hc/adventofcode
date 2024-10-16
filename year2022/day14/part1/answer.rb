require_relative '../cave'

module Year2022
  module Day14
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          cave.scan unless cave.scanned?

          count = 0

          loop do
            sand = cave.pour_sand

            if sand.flew_into_abyss?
              break
            else
              count += 1
            end
          end

          cave.draw

          puts "The number of units of sand come to rest before sand starts flowing into the abyss below: #{count}"
        end

        def input_path
          File.join(File.dirname(__FILE__), '../input.txt')
        end

        def cave
          @cave ||= Year2022::Day14::Cave.new(input_path)
        end
      end
    end
  end
end
