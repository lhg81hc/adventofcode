module Year2022
  module Day5
    class RearrangementProcedure
      attr_reader :stacks, :rearrangement_steps

      def initialize(stacks, rearrangement_steps)
        @stacks = stacks
        @rearrangement_steps = rearrangement_steps
      end

      def move_one_by_one
        dup_stacks = Marshal.load(Marshal.dump(stacks))

        rearrangement_steps.each_with_index do |step|
          from_stack = dup_stacks[step.from_stack_index]
          to_stack = dup_stacks[step.to_stack_index]

          step.number_of_crates.times { to_stack.push(from_stack.pop) }
        end

        dup_stacks
      end

      def move_multiple_at_once
        dup_stacks = Marshal.load(Marshal.dump(stacks))

        rearrangement_steps.each_with_index do |step|
          from_stack = dup_stacks[step.from_stack_index]
          to_stack = dup_stacks[step.to_stack_index]

          to_stack.concat(from_stack.pop(step.number_of_crates))
        end

        dup_stacks
      end
    end
  end
end
