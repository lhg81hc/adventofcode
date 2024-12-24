require_relative '../safety_manual_updates'
require_relative '../safety_manual_update_correction'

module Year2024
  module Day5
    module Part2
      class Answer
        def self.run
          new.run
        end

        def run
          puts "The incorrectly-ordered updates and their correct orderings:\n\n"

          sum = 0

          safety_manual_updates.incorrect_order_updates.each do |incorrect_order_update|
            ordered_page_numbers = correctly_ordered_page_numbers(incorrect_order_update)
            puts "#{incorrect_order_update.page_numbers.join(',')} becomes #{ordered_page_numbers.join(',')}"
            sum += ordered_page_numbers[ordered_page_numbers.length / 2].to_i
          end

          puts "\nThe sum of the middle page numbers after correctly ordering the incorrectly-ordered updates: #{sum}"
        end

        def safety_manual_updates
          @safety_manual_updates ||= Year2024::Day5::SafetyManualUpdates.new(filepath)
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end

        def correctly_ordered_page_numbers(incorrect_order_update)
          Year2024::Day5::SafetyManualUpdateCorrection
            .new(incorrect_order_update, safety_manual_updates.page_ordering_rules)
            .correctly_ordered_page_numbers
        end
      end
    end
  end
end
