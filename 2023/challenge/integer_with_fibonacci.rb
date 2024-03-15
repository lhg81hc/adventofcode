module Challenge
  module IntegerWithFibonacci
    refine Integer do
      FIRST_TWO_FIBONACCI_NUMBERS = [0, 1].freeze

      def to_sequence_of_fibonacci_numbers
        t = FIRST_TWO_FIBONACCI_NUMBERS.dup

        return [0] if self.zero?
        return t if self == 1

        (2..self).each do |idx|
          t[idx] = t[idx - 1] + t[idx - 2]
        end

        t
      end

      def as_upper_limit_of_fibonacci_sequence
        t = FIRST_TWO_FIBONACCI_NUMBERS.dup

        return [0] if self.zero?
        return t if self == 1

        idx = 2

        loop do
          next_fibo_number = t[idx - 1] + t[idx - 2]
          break if next_fibo_number > self

          t[idx] = next_fibo_number
          idx += 1
        end

        t
      end
    end
  end
end
