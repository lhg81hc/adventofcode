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

    def generate_arrangement(records, l)
      if l == records.length
        spring_condition_parser = Day12::SpringConditionParser.new(records)
        damaged_group_sizes = spring_condition_parser.damaged_group_sizes
        @arrangements << records.dup if damaged_group_sizes == recorded_damaged_group_sizes

        return nil
      end

      if records[l] == UNKNOWN
        records[l] = OPERATIONAL
        if possible_arrangement?(records)
          generate_arrangement(records, l + 1)
        end

        records[l] = DAMAGED
        if possible_arrangement?(records)
          generate_arrangement(records, l + 1)
        end

        records[l] = UNKNOWN
      else
        generate_arrangement(records, l + 1)
      end
    end

    def possible_arrangement?(arrangement)
      damaged_springs_count = 0
      unknown_springs_count = 0

      arrangement.each_char do |c|
        unknown_springs_count += 1 if c == UNKNOWN
        damaged_springs_count += 1 if c == DAMAGED
      end

      if unknown_springs_count.zero?
        groups = arrangement.scan(/#+/)
        return true if groups.length.zero? || groups.length == 1

        groups[0..-2].each.with_index do |group, idx|
          if recorded_damaged_group_sizes[idx] != group.length
            return false
          end
        end

        true
      else
        damaged_springs_count + unknown_springs_count >= total_damaged_springs
      end
    end

    def total_damaged_springs
      @total_damaged_springs ||= recorded_damaged_group_sizes.sum
    end
  end
end
