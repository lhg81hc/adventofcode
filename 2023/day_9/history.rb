module Day9
  class History
    attr_reader :str

    def initialize(str)
      @str = str
    end

    def values
      @values ||= str.scan(/-?\d+/).map(&:to_i)
    end

    def prediction_of_the_next_value
      @prediction_of_the_next_value ||= predict_the_next_value(values)
    end

    private

    def predict_the_next_value(vals)
      if vals.length == 1 && !vals.first.zero?
        raise 'Reached the end of algorithm but some of the differences are not Zeros'
      end

      difference_between_steps, all_differences_are_zeros = diff_between_steps(vals)

      if all_differences_are_zeros
        vals.last
      else
        predict_the_next_value(difference_between_steps) + vals.last
      end
    end

    def diff_between_steps(steps)
      all_differences_are_zeros = true
      difference_between_steps =
        steps.each_with_index.inject([]) do |r, (val, idx)|
          if idx.zero?
            r
          else
            diff = val - steps[idx - 1]
            all_differences_are_zeros = false unless diff.zero?
            r << diff
            r
          end
        end

      [difference_between_steps, all_differences_are_zeros]
    end
  end
end
