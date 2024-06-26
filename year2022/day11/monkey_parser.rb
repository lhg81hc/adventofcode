require_relative 'monkey'

module Year2022
  module Day11
    class MonkeyParser
      attr_reader :lines

      def initialize(lines)
        @lines = lines
      end

      def self.parse(lines)
        new(lines).parse
      end

      def parse
        monkey_name = parse_monkey_name(lines[0])
        holding_items = parse_holding_items(lines[1])
        arithmetic_operator, arithmetic_operand = parse_operation(lines[2])
        divisible_by = parse_divisible_by(lines[3])
        next_monkey_if_true, next_monkey_if_false = parse_decision(lines[4..5])

        Year2022::Day11::Monkey.new(
          monkey_name,
          holding_items,
          arithmetic_operator,
          arithmetic_operand,
          divisible_by,
          next_monkey_if_true,
          next_monkey_if_false
        )
      end

      def parse_decision(decision_lines)
        next_monkey_if_true = nil
        next_monkey_if_false = nil

        decision_lines.each do |line|
          next_monkey_if_true = line.match(/-?\d+/)[0] if line.include?('true')
          next_monkey_if_false = line.match(/-?\d+/)[0] if line.include?('false')
        end

        [next_monkey_if_true, next_monkey_if_false]
      end

      def parse_divisible_by(line)
        line.match(/-?\d+/)[0].to_i
      end

      def parse_monkey_name(line)
        line.match(/-?\d+/)[0]
      end

      def parse_holding_items(line)
        line.scan(/-?\d+/).map(&:to_i)
      end

      def parse_operation(line)
        arithmetic_operator = line.match(/[+\-*\/]/)[0]
        arithmetic_operand = line.match(/old$/)
        arithmetic_operand = arithmetic_operand ? arithmetic_operand[0] : line.match(/-?\d+/)[0].to_i

        [arithmetic_operator, arithmetic_operand]
      end
    end
  end
end
