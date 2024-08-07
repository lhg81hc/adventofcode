require_relative '../input_parser'
require_relative '../package_comparison'

module Year2022
  module Day13
    module Part2
      class Answer
        include PackageComparison

        DIVIDER_PACKAGE_LINES = ['[[2]]', '[[6]]'].freeze

        def self.run
          new.run
        end

        # Idea: Use 'Merge Sort'
        def run
          packages = parsed_packages + divider_packages
          sorted_packages = merge_sort_package(packages, 0, packages.length - 1)

          sorted_packages.each.with_index do |package, idx|
            if DIVIDER_PACKAGE_LINES[0] == package.str || DIVIDER_PACKAGE_LINES[1] == package.str
              puts "#{package.str} => #{idx + 1}th"
            end
          end
        end

        def parsed_packages
          input_parser.parse_packages
        end

        def divider_packages
          DIVIDER_PACKAGE_LINES.map { |line| package_parser.parse(line) }
        end

        def package_parser
          @package_parser ||= Year2022::Day13::PackageParser.new
        end

        def input_parser
          @input_parser ||= Year2022::Day13::InputParser.new(input_path)
        end

        def input_path
          File.join(File.dirname(__FILE__), '../input.txt')
        end

        protected

        def merge(arr, left, mid, right)
          n1 = mid - left + 1
          n2 = right - mid

          l = []
          r = []

          (0..n1-1).each do |i|
            l[i] = arr[left + i]
          end

          (0..n2-1).each do |i|
            r[i] = arr[mid + i + 1]
          end

          i = 0
          j = 0
          k = left

          while i < n1 && j < n2
            first_group_item = Year2022::Day13::GroupItem.new(l[i].items)
            second_group_item = Year2022::Day13::GroupItem.new(r[j].items)

            if compare_group_items(first_group_item, second_group_item) != WRONG_ORDER
              arr[k] = l[i]
              i += 1
            else
              arr[k] = r[j]
              j += 1
            end

            k += 1
          end

          while i < n1
            arr[k] = l[i]
            i += 1
            k += 1
          end

          while j < n2
            arr[k] = r[j]
            j += 1
            k += 1
          end
        end

        def merge_sort_package(arr, left, right)
          if left < right
            mid = (left + right) / 2
            merge_sort_package(arr, left, mid)
            merge_sort_package(arr, mid + 1, right)
            merge(arr, left, mid, right)
          end

          arr
        end
      end
    end
  end
end
