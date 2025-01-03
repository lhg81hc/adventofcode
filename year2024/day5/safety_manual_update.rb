module Year2024
  module Day5
    class SafetyManualUpdate
      attr_reader :str

      def initialize(str)
        @str = str
      end

      def page_numbers
        @page_numbers ||= str.split(',')
      end

      def page_pairs
        @page_pairs ||=
          begin
            length = page_numbers.length
            return [] unless length >= 2

            page_numbers.each.with_index.inject([]) do |r, (_page_number, idx)|
              r += ((idx + 1)..(length - 1)).map { |i| [page_numbers[idx], page_numbers[i]] } if idx != length - 1
              r
            end
          end
      end

      def middle_page_number
        page_numbers[page_numbers.length / 2]
      end

      def find_incorrect_order_page_pair(page_ordering_rules)
        page_pairs.each do |pair|
          return pair unless page_ordering_rules.right_order?(*pair)
        end

        nil
      end

      def correct_order?(page_ordering_rules)
        find_incorrect_order_page_pair(page_ordering_rules).nil?
      end
    end
  end
end
