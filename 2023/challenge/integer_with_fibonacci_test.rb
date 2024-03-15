require_relative 'integer_with_fibonacci'
require 'test/unit'

module Challenge
  class IntegerWithFibonacciTest < Test::Unit::TestCase
    using Challenge::IntegerWithFibonacci

    def test_sequence_of_fibonacci_numbers
      assert_equal(0.to_sequence_of_fibonacci_numbers, [0])
      assert_equal(1.to_sequence_of_fibonacci_numbers, [0, 1])
      assert_equal(5.to_sequence_of_fibonacci_numbers, [0, 1, 1, 2, 3, 5])
    end

    def test_as_upper_limit_of_fibonacci_sequence
      assert_equal(0.as_upper_limit_of_fibonacci_sequence, [0])
      assert_equal(1.as_upper_limit_of_fibonacci_sequence, [0, 1])
      assert_equal(2.as_upper_limit_of_fibonacci_sequence, [0, 1, 1, 2])
      assert_equal(10.as_upper_limit_of_fibonacci_sequence, [0, 1, 1, 2, 3, 5, 8])
    end
  end
end
