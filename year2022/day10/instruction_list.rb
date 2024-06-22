module Year2022
  module Day10
    class InstructionList
      attr_reader :list

      def initialize(list = [])
        @list = list
      end

      alias :instructions :list

      def add_instruction(instruction)
        @list << instruction
      end

      def addx_values_after_n_cycles(n)
        i = 0
        l = [1]

        while i < n do
          instructions.each do |instruction|
            l << instruction.value if i + instruction.number_of_required_cycles < n && instruction.addx?
            i += instruction.number_of_required_cycles

            break if i >= n
          end
        end

        l
      end
    end
  end
end
