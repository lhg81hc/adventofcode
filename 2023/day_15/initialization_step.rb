require_relative 'hashing_ulti'

module Day15
  class InitializationStep
    include HashingUtil

    attr_reader :step_val

    def initialize(step_val)
      @step_val = step_val
    end

    def label_of_the_lens
      @label_of_the_lens ||= step_val[/\w+/]
    end

    def box_no
      @box_no ||= hash(label_of_the_lens)
    end

    def operation
      @operation ||= step_val[/[=|-]/]
    end

    def focal_length
      @focal_length ||= step_val[/\d+/]&.to_i
    end
  end
end
