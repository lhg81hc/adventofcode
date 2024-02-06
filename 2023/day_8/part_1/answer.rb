require_relative '../node'

module Day8
  module Part1
    class Answer
      INPUT_FILE = '../input.txt'

      attr_reader :network

      ORIGIN = 'AAA'
      DESTINATION = 'ZZZ'

      def initialize
        @network = build_network
        @current_node = @network[ORIGIN]
        @current_step_idx = 0
        @total_steps = 0
      end

      def self.run
        new.run
      end

      def run
        while @current_step_idx <= instructions.length - 1
          @total_steps += 1
          next_value = @current_node.turn(direction)
          @current_node = @network[next_value]
          break if destination_node?

          if @current_step_idx == instructions.length - 1
            @current_step_idx = 0 unless destination_node?
          else
            @current_step_idx += 1
          end
        end
      end

      def direction
        instructions[@current_step_idx]
      end

      def destination_node?
        @current_node.value == DESTINATION
      end

      def instructions
        @instructions ||= lines[0].scan(/\w/)
      end

      def lines
        @lines ||= input_file.readlines
      end

      def input_file
        @input_file ||= File.open(input_path)
      end

      def build_network
        lines[2..-1].inject({}) do |result, line|
          node = Day8::Node.new(line)

          result[node.value] = node
          result
        end
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end
    end
  end
end
