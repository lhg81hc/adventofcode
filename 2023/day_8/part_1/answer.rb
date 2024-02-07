require 'forwardable'
require_relative '../network'

module Day8
  module Part1
    class Answer
      extend Forwardable

      INPUT_FILE = '../input.txt'
      ORIGIN = 'AAA'
      DESTINATION = 'ZZZ'

      attr_reader :current_value, :current_step_idx, :total_steps

      def initialize
        @current_value = ORIGIN
        @current_step_idx = 0
        @total_steps = 0
      end

      def self.run
        new.run
      end

      def run
        while @current_step_idx <= instructions_length - 1
          @total_steps += 1
          @current_value = current_node.turn(direction)

          break if destination_node?

          if @current_step_idx == instructions_length - 1
            @current_step_idx = 0 unless destination_node?
          else
            @current_step_idx += 1
          end
        end

        puts "Number of steps are required to reach ZZZ: #{total_steps}"
      end

      def network
        @network ||= Day8::Network.new(input_path)
      end

      def_delegators :network, :map, :instructions, :instructions_length

      def direction
        instructions[current_step_idx]
      end

      def destination_node?
        current_value == DESTINATION
      end

      def current_node
        map[current_value]
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end
    end
  end
end
