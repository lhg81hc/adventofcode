require_relative '../product_id_ranges'

module Year2025
  module Day2
    module Part2
      class Answer
        def self.run
          new.run
        end

        def run
          total = 0

          File.open(input_filepath).readlines.each do |line|
            stripped_line = line.strip
            stripped_line.split(',').each do |range|
              product_id_ranges = Year2025::Day2::ProductIdRanges.new(range)
              puts range
              puts product_id_ranges.repeated_ids.join(", ")
              total += product_id_ranges.repeated_ids.sum
            end
          end

          puts "Adding up all the invalid IDs in this example produces #{total}"
        end

        def input_filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
