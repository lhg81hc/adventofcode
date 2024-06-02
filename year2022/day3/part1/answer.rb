require_relative '../rucksack'
require_relative '../supply_item'
require_relative '../common_item_types_finder'

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
              common_item_types = common_item_types_from_line(line.strip)
              t += common_item_types_priorities(common_item_types)
              t
            end

          puts "The the sum of the priorities of those common item types #{total}"
        end

        def common_item_types_from_line(line)
          rucksack = Year2022::Day3::Rucksack.new(line.strip)
          Year2022::Day3::CommonItemTypesFinder.new([rucksack.first_compartment, rucksack.second_compartment]).find
        end

        def common_item_types_priorities(common_item_types)
          common_item_types.reduce(0) do |sum, type|
            sum += Year2022::Day3::SupplyItem.new(type).priority
            sum
          end
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
