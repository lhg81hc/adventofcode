module Day12
  class LineParser
    attr_reader :line, :num_of_folds

    def initialize(line, num_of_folds: 1)
      @line = line
      @num_of_folds = num_of_folds
    end

    def damage_records
      @damage_records ||=
        begin
          copies = Array.new(num_of_folds) { line.split[0] }
          copies.join('?')
        end
    end

    def size_of_each_contiguous_group_of_damaged_springs
      @size_of_each_contiguous_group_of_damaged_springs ||=
        line.split[1].scan(/\w+/).map(&:to_i) * num_of_folds
    end
  end
end
