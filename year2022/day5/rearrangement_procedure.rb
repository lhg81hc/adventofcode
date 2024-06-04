module Year2022
  module Day5
    class RearrangementProcedure
      attr_reader :stacks, :rearrangement_steps

      def initialize(stacks, rearrangement_steps)
        @stacks = stacks
        @rearrangement_steps = rearrangement_steps
      end

      def perform
        dup_stacks = Marshal.load(Marshal.dump(stacks))

        rearrangement_steps.each_with_index do |step|
          step.number_of_crates.times do
            from_stack = dup_stacks[step.from_stack_index]
            to_stack = dup_stacks[step.to_stack_index]
            to_stack = dup_stacks[step.to_stack_index]

            to_stack.push(from_stack.pop)
          end
        end

        dup_stacks
      end
    end
  end
end
