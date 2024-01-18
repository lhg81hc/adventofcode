require_relative '../scratchcard_reader'
require_relative 'tree_node'

# {1=>1, 2=>2, 3=>4, 4=>8, 5=>16, 6=>32, 7=>64, 8=>127, 9=>254, 10=>508, 11=>1016, 12=>2000, 13=>3807, 14=>7102, 15=>14196, 16=>28122, 17=>56244, 18=>105386, 19=>210772, 20=>335178, 21=>669340, 22=>985498, 23=>985498}

module Day4
  module Part2
    class ScratchcardCounter
      attr_reader :sum

      def initialize
        @sum = 0
        @map = {}
        @s = {}
      end

      def self.count
        new.count
      end

      def count
        line_index = 0

        loop do
          update_map(line_index)
          line_index += 1
          break if total_matched_numbers == 0 || line_index >= last_line_index
        end

        puts pp @map

        # loop do
        #   build_tree_node(nil, line_index)
        #   line_index += 1
        #
        #   break if Day4::ScratchcardReader.new(lines[line_index]).total_matched_numbers == 0 || line_index >= last_line_index
        # end
      end

      def update_map(line_index)
        init_scratchcard_reader(lines[line_index])
        next_scratchcard_order_numbers = (1 .. total_matched_numbers).map { |n| card_order_number + n }.select { |n| n - 1 <= last_line_index }
        @map[card_order_number] = next_scratchcard_order_numbers
      end

      def build_tree_node(parent_value, line_index)
        init_scratchcard_reader(lines[line_index])
        update_stat(card_order_number)

        if total_matched_numbers == 0
          nil
        else
          next_scratchcard_order_numbers = (1 .. total_matched_numbers).map { |n| card_order_number + n }.select { |n| n - 1 <= last_line_index }
          tree_children = next_scratchcard_order_numbers.map { |n| build_tree_node(card_order_number, n - 1) }
          TreeNode.new(parent_value, tree_children)
        end
      end

      def input_file
        @input_file ||= File.open(input_path)
      end

      def lines
        @lines ||= input_file.readlines
      end

      def total_lines
        @total_lines ||= lines.count
      end

      def last_line_index
        @last_line_index ||= total_lines - 1
      end

      def scratchcard_reader
        @scratchcard_reader
      end

      # def update_stat(order_number)
      #   @s[order_number] ||= 0
      #   @s[order_number] += 1
      #   puts @s
      # end

      def init_scratchcard_reader(line)
        @scratchcard_reader = Day4::ScratchcardReader.new(line)
      end

      def total_matched_numbers
        scratchcard_reader.total_matched_numbers
      end

      def card_order_number
        scratchcard_reader.card_order_number
      end

      def input_path
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
