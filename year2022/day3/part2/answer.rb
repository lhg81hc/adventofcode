require_relative '../rucksack'
require_relative '../supply_item'
require_relative '../common_item_types_finder'

module Year2022
  module Day3
    module Part2
      class Answer
        def self.run
          new.run
        end

        def run
          group_of_three = []

          total =
            File.foreach(filepath).inject(0) do |t, line|
              group_of_three = [] if group_of_three.length == 3
              group_of_three << line.strip

              if group_of_three.length == 3
                common_types = common_item_types(group_of_three)
                t += common_item_types_priorities(common_types)
              end

              t
            end

          puts "The the sum of the priorities of those common item types #{total}"
        end

        def common_item_types(lines)
          supply_items_list = lines.map { |line| Year2022::Day3::Rucksack.new(line).supply_items }
          Year2022::Day3::CommonItemTypesFinder.new(supply_items_list).find
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
