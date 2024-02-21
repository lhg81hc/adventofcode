module Day12
  class LineParser
    attr_reader :line

    def initialize(line)
      @line = line
    end

    def damage_records
      @damage_records ||= line.split[0]
    end

    def size_of_each_contiguous_group_of_damaged_springs
      @size_of_each_contiguous_group_of_damaged_springs ||= line.split[1].scan(/\w+/).map(&:to_i)
    end
  end
end
