require 'forwardable'
require 'pry'

module Year2024
  module Day5
    class SafetyManualUpdateCorrection
      extend Forwardable

      attr_reader :safety_manual_update, :page_ordering_rules

      def initialize(safety_manual_update, page_ordering_rules)
        @safety_manual_update = safety_manual_update
        @page_ordering_rules = page_ordering_rules
      end

      def_delegators :safety_manual_update, :page_numbers

      def correctly_ordered_page_numbers
        dup_page_numbers = page_numbers.dup

        quick_sort(dup_page_numbers, 0, page_numbers.length - 1)

        dup_page_numbers
      end

      def correctly_order_page_numbers_using_backtracking
        dup_page_numbers = page_numbers.dup
        permutations(dup_page_numbers, 0)
      end

      def permutations(arr, idx)
        if idx == arr.length
          if correctly_ordered_permutation(arr)
            return arr
          else
            return nil
          end
        end

        (idx..(arr.length - 1)).each do |i|
          swap(arr, idx, i)

          result = permutations(arr, idx + 1)
          return result unless result.nil?

          swap(arr, idx, i)
        end

        nil
      end

      def pairs(arr)
        length = arr.length
        return [] unless length >= 2

        arr.each.with_index.inject([]) do |r, (_e, idx)|
          r += ((idx + 1)..(length - 1)).map { |i| [arr[idx], arr[i]] } if idx != length - 1
          r
        end
      end

      def correctly_ordered_permutation(permutation)
        pairs(permutation).all? { |pair| page_ordering_rules.right_order?(*pair) }
      end

      private

      def partition(arr, low, high)
        pivot = arr[high]
        i = low - 1

        (low..high).each do |j|
          if page_ordering_rules.order(arr[j], pivot).positive?
            i += 1
            swap(arr, i, j)
          end
        end

        swap(arr, i + 1, high)
        i + 1
      end

      def swap(arr, first_idx, second_idx)
        arr[first_idx], arr[second_idx] = arr[second_idx], arr[first_idx]
      end

      def quick_sort(arr, low, high)
        return unless low < high

        pi = partition(arr, low, high)
        quick_sort(arr, low, pi - 1)
        quick_sort(arr, pi + 1, high)
      end
    end
  end
end
