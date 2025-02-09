require_relative '../disk_map'

module Year2024
  module Day9
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          puts "The resulting filesystem checksum: #{disk_map.best_calculate_checksum}"
        end

        def disk_map
          @disk_map ||= Year2024::Day9::DiskMap.new(input_filepath)
        end

        def input_filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
