require_relative '../cave_scanner'

module Year2022
  module Day16
    module Part1
      class Answer
        ROW_IDX = 2000000

        def self.run
          new.run
        end

        def run
          cave_scanner.scan unless cave_scanner.scanned?

          a =
            cave_scanner.valves.map do |valve|
              valve.to_s
            end

          p a
        end

        def input_path
          File.join(File.dirname(__FILE__), '../input.txt')
        end

        def cave_scanner
          @cave_scanner ||= Year2022::Day16::CaveScanner.new(input_path)
        end
      end
    end
  end
end
