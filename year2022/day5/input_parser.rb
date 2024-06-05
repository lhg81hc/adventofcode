require_relative 'rearrangement_step'

module Year2022
  module Day5
    class InputParser
      attr_reader :filepath, :stacks, :rearrangement_steps

      def initialize(filepath)
        @filepath = filepath
        @stacks = []
        @rearrangement_steps = []
      end

      def self.parse(filepath)
        new(filepath).parse
      end

      def parse
        @stacks = []
        @rearrangement_steps = []

        File.foreach(filepath) do |line|
          chomped_line = line.chomp

          if rearrangement_step?(line)
            add_rearrangement_step(chomped_line)
          elsif stack_columns?(line)
            build_stacks(chomped_line)
          end
        end

        self
      end

      def add_rearrangement_step(line)
        @rearrangement_steps << Year2022::Day5::RearrangementStep.new(line)
      end

      def build_stacks(line)
        stack_index = 0
        curr_char_index = 0
        last_char_index = line.length - 1

        while curr_char_index < last_char_index
          crate_str = line[curr_char_index..(curr_char_index + 2)]

          if crate_str[0] == '[' && crate_str[-1] == ']'
            @stacks[stack_index] ||= []
            @stacks[stack_index].prepend(crate_str[1])
          end

          stack_index += 1
          curr_char_index += 4
        end
      end

      def stack_columns?(line)
        curr_index = 0
        last_index = line.length - 1

        while curr_index < last_index
          crate_str = line[curr_index..(curr_index + 2)]
          return true if crate_str[0] == '[' && crate_str[-1] == ']'

          curr_index += 4
        end

        false
      end

      def rearrangement_step?(line)
        line.start_with?('move')
      end

      def ordinal_numbers?(line)
        !line.empty? && line.each_char.all? { |char| char == ' ' || %w(1 2 3 4 5 6 7 8 9).include?(char) }
      end
    end
  end
end
