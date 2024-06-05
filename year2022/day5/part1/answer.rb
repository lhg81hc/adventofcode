require_relative '../input_parser'
require_relative '../crane'

module Year2022
  module Day5
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          dup_stacks = Marshal.load(Marshal.dump(input_parser.stacks))
          crane = Year2022::Day5::Crane.new(dup_stacks)
          input_parser.rearrangement_steps.each { |step| crane.move_one_by_one(step) }

          puts "After the rearrangement procedure completes: #{dup_stacks.map { |stack| stack.last }.join}"
        end

        def input_parser
          @input_parser ||= Year2022::Day5::InputParser.parse(filepath)
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
