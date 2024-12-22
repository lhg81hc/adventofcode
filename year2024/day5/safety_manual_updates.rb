require_relative './safety_manual_update'
require_relative './page_ordering_rules'

module Year2024
  module Day5
    class SafetyManualUpdates
      attr_reader :input_path

      def initialize(input_path)
        @input_path = input_path
      end

      def updates
        @updates ||=
          File.foreach(input_path).each_with_object([]) do |line, r|
            stripped_line = line.strip
            next unless stripped_line.match(/(\d+,)+(\d+)$/)

            r << Year2024::Day5::SafetyManualUpdate.new(stripped_line)
          end
      end

      def correct_order_updates
        @correct_order_updates ||= updates_partition[0]
      end

      def incorrect_order_updates
        @incorrect_order_updates ||= updates_partition[1]
      end

      def updates_partition
        updates.each_with_object([]) do |update, r|
          r[0] ||= []
          r[1] ||= []

          if update_contains_pages_in_correct_orders?(update)
            r[0] << update
          else
            r[1] << update
          end
        end
      end

      def page_ordering_rules
        @page_ordering_rules ||= Year2024::Day5::PageOrderingRules.new(input_path)
      end

      private

      def update_contains_pages_in_correct_orders?(update)
        update.page_pairs.each do |pair|
          return false unless page_ordering_rules.right_order?(*pair)
        end

        true
      end
    end
  end
end
