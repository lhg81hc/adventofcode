require 'forwardable'
require_relative '../my_math'
require_relative '../network'

module Day8
  module Part2
    class Answer
      extend Forwardable
      include MyMath

      INPUT_FILE = '../input.txt'

      def self.run
        new.run
      end

      def run
        puts "The number of steps it takes before you're only on nodes that end with Z: #{least_common_multiple(*num_of_required_steps)}"
      end

      def network
        @network ||= Day8::Network.new(input_path)
      end

      def_delegators :network, :map, :instructions, :instructions_length

      def num_of_required_steps
        all_num_of_steps_found = false
        num_of_steps = []
        count = 0

        until all_num_of_steps_found
          count += 1

          current_nodes.each.with_index do |node, idx|
            next unless num_of_steps[idx].nil?

            current_step_idx = step_idx_by_number_of_steps(count)
            next_node = network.find_node_after_num_of_steps(node, current_step_idx, 1)
            @current_nodes[idx] = next_node

            if next_node.value.end_with?('Z')
              num_of_steps[idx] = count
              all_num_of_steps_found = num_of_steps.length > 0 && num_of_steps.all? { |n| !n.nil? }
            end
          end
        end

        num_of_steps
      end

      def step_idx_by_number_of_steps(number_of_steps)
        if number_of_steps == 0
          0
        elsif number_of_steps <= instructions_length
          number_of_steps - 1
        else
          int_remainder = number_of_steps % instructions_length

          if int_remainder.zero?
            instructions_length - 1
          else
            int_remainder - 1
          end
        end
      end

      def starting_nodes
        @starting_nodes ||=
          map.inject([]) do |r, (k, v)|
            r << v if k.end_with?('A')
            r
          end
      end

      def current_nodes
        @current_nodes ||= starting_nodes
      end

      def input_file
        @input_file ||= File.open(input_path)
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end
    end
  end
end
