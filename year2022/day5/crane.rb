require 'forwardable'

module Year2022
  module Day5
    class Crane
      extend Forwardable

      attr_reader :stacks
      def_delegators :@rearrangement_step, :number_of_crates

      def initialize(stacks)
        @stacks = stacks
      end

      def move_one_by_one(step)
        @rearrangement_step = step
        number_of_crates.times { to_stack.push(from_stack.pop) }
      end

      def move_multiple_at_once(step)
        @rearrangement_step = step
        to_stack.concat(from_stack.pop(number_of_crates))
      end

      private

      def from_stack
        stacks[@rearrangement_step.from_stack_index]
      end

      def to_stack
        stacks[@rearrangement_step.to_stack_index]
      end
    end
  end
end
