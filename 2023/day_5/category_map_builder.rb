module Day5
  class CategoryMapBuilder
    attr_reader :lines, :name, :map

    def initialize(name, lines)
      @lines = lines
      @name = name
      @map = []
    end

    def self.build(*args)
      new(*args).build
    end

    def build
      lines.each do |line|
        numbers = line.split(' ').map(&:to_i)

        @map << {
          dest_range_start: numbers[0],
          source_range_start: numbers[1],
          range_length: numbers[2]
        }
      end

      self
    end

    def find_destination(num)
      found = map.find { |h| h[:source_range_start] <= num && num <= h[:source_range_start] + h[:range_length] }

      if found.nil?
        num
      else
        found[:dest_range_start] + (num - found[:source_range_start])
      end
    end
  end
end
