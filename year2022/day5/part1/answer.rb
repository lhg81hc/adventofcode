require_relative '../input_parser'
require_relative '../rearrangement_procedure'

module Year2022
  module Day5
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          input_parser.parse
          rearrangement_procedure = Year2022::Day5::RearrangementProcedure.new(input_parser.stacks, input_parser.rearrangement_steps)
          rearranged_stacks = rearrangement_procedure.perform

          puts "After the rearrangement procedure completes: #{rearranged_stacks.map { |stack| stack.last }.join}"
        end

        def input_parser
          @input_parser ||= Year2022::Day5::InputParser.new(filepath)
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
