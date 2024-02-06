require_relative 'custom_range'

module Day5
  class CategoryMapTable
    attr_reader :lines, :name

    CategoryMap = Struct.new(:dest_range, :source_range, :range_length)

    def initialize(name, lines)
      @lines = lines
      @name = name
    end

    def table
      @table ||= lines.map { |l| build_category_map_from_line(l) }
    end

    def find_destination(num)
      found = table.find { |cm| cm.source_range.cover?(num) }
      found.nil? ? num : found.dest_range.first + (num - found.source_range.first)
    end

    def find_destination_ranges(range)
      arr = [range.first, range.last]

      table.each { |cm| arr += [cm.source_range.first, cm.source_range.last] if range.overlap?(cm.source_range) }
      arr = arr.select { |n| n >= range.first && n <= range.last }.sort
      arr = arr.map.with_index { |_n, idx| CustomRange.new(arr[idx], arr[idx + 1]) }.select { |r| !r.end.nil? }

      arr.map do |r|
        found =
          table.find do |h|
            ([h.source_range.begin, h.source_range.end] & [r.begin, r.end]).any? ||
              (h.source_range.begin <= r.begin && r.end <= h.source_range.end)
          end

        if found
          CustomRange.new(found.dest_range.begin + (r.begin - found.source_range.begin), found.dest_range.begin + (r.begin - found.source_range.begin) + (r.end - r.begin))
        else
          r
        end
      end
    end

    def build_category_map_from_line(line)
      numbers = line.split(' ').map(&:to_i)
      dest_range = CustomRange.new(numbers[0], numbers[0] + numbers[2] - 1)
      source_range = CustomRange.new(numbers[1], numbers[1] + numbers[2] - 1)

      CategoryMap.new(dest_range, source_range, numbers[2])
    end
  end
end
