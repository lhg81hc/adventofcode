require_relative 'spring_condition_parser'

module Day12
  class ArrangementGenerator
    UNKNOWN = '?'
    DAMAGED = '#'
    OPERATIONAL = '.'

    attr_reader :damaged_condition_records, :recorded_damaged_group_sizes

    def initialize(damaged_condition_records, recorded_damaged_group_sizes)
      @damaged_condition_records = damaged_condition_records
      @recorded_damaged_group_sizes = recorded_damaged_group_sizes
      @arrangements = []
      @count = 0
    end

    def possible_arrangements
      @possible_arrangements ||=
        begin
          generate_arrangement(damaged_condition_records.dup, 0)
          @arrangements
        end
    end

    def generate_arrangement(records, idx)
      # Base case: All '?' are replaced
      if idx == total_unknown_condition_springs
        spring_condition_parser = Day12::SpringConditionParser.new(records)
        damaged_group_sizes = spring_condition_parser.damaged_group_sizes
        @arrangements << records.dup if damaged_group_sizes == recorded_damaged_group_sizes

        return true
      end

      records[idx_of_unknown_condition_springs[idx]] = OPERATIONAL
      if possible_arrangement?(records)
        generate_arrangement(records, idx + 1)
      end

      records[idx_of_unknown_condition_springs[idx]] = DAMAGED
      if possible_arrangement?(records)
        generate_arrangement(records, idx + 1)
      end
    end

    def possible_arrangement?(arrangement)
      n =
        arrangement.each_char.inject(0) do |r, c|
          r += 1 if c == UNKNOWN || c == DAMAGED
          r
        end

      n >= total_damaged_springs
    end

    def total_unknown_condition_springs
      @total_unknown_condition_springs ||= idx_of_unknown_condition_springs.length
    end

    def total_damaged_springs
      @total_damaged_springs ||= recorded_damaged_group_sizes.sum
    end

    def idx_of_unknown_condition_springs
      @idx_of_unknown_condition_springs ||=
        begin
          damaged_condition_records.each_char.with_index.inject([]) do |r, (char, idx)|
            r << idx if char == '?'
            r
          end
        end
    end
  end
end
