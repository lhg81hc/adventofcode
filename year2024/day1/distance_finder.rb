require_relative './radix_sort_extension'

module Year2024
  module Day1
    class DistanceFinder
      using RadixSortExtension

      attr_reader :first_list, :second_list

      def initialize(first_list, second_list)
        @first_list = first_list
        @second_list = second_list
      end

      def sorted_first_list
        raise ArgumentError unless first_list.is_a?(Array)

        @sorted_first_list ||= first_list.radix_sort!
      end

      def sorted_second_list
        raise ArgumentError unless second_list.is_a?(Array)

        @sorted_second_list ||= second_list.radix_sort!
      end

      def distance
        (0..(sorted_first_list.length - 1)).inject(0) do |r, idx|
          r += (sorted_first_list[idx] - sorted_second_list[idx]).abs
          r
        end
      end
    end
  end
end