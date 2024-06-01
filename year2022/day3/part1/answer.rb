require_relative '../rucksack'
require_relative '../supply_item'

module Year2022
  module Day3
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          total =
            File.foreach(filepath).inject(0) do |t, line|
              rucksack = Year2022::Day3::Rucksack.new(line.strip)
              common_item_types = rucksack.common_item_types

              t +=
                common_item_types.inject(0) do |sum, type|
                  sum += Year2022::Day3::SupplyItem.new(type).priority
                  sum
                end

              t
            end

          puts "The the sum of the priorities of those common item types #{total}"
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
