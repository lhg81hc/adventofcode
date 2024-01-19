require_relative 'custom_range'

module Day5
  class CategoryMapTable
    attr_reader :lines, :name

    CategoryMap = Struct.new(:dest_range, :source_range, :range_length)

    def initialize(name, lines)
      @lines = lines
      @name = name
    end

    def map
      @map ||=
        lines.map do |line|
          numbers = line.split(' ').map(&:to_i)
          dest_range = CustomRange.new(numbers[0], numbers[0] + numbers[2])
          source_range = CustomRange.new(numbers[1], numbers[1] + numbers[2])

          CategoryMap.new(dest_range, source_range, numbers[2])
        end
    end

    def find_destination(num)
      found = map.find { |cm| cm.source_range.cover?(num) }
      found.nil? ? num : found.dest_range.first + (num - found.source_range.first)
    end

    def find_range(range)
      found = map.find { |h| (h.source_range_start <= range.end) && (range.begin <= h.source_range_start + h.range_length) }

      found.nil?
    end
  end
end
