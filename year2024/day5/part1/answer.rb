require_relative '../safety_manual_updates'

module Year2024
  module Day5
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          puts "The correctly-ordered updates are:"

          sum = 0
          safety_manual_updates.correct_order_updates.each do |update|
            sum += update.middle_page_number.to_i
            p update.str
          end

          puts "The sum of middle page number from those correctly-ordered updates: #{sum}"
        end

        def safety_manual_updates
          @safety_manual_updates ||= Year2024::Day5::SafetyManualUpdates.new(filepath)
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
