module Day12
  class SpringConditionParser
    attr_reader :condition_records

    def initialize(condition_records)
      @condition_records = condition_records
    end

    def damaged_group_sizes
      @damaged_group_sizes ||= damaged_groups.map(&:length)
    end

    def damaged_groups
      @damaged_groups ||= condition_records.scan(/#+/)
    end
  end
end
