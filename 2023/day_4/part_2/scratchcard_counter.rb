require_relative '../scratchcard_reader'
require_relative 'tree_node'

module Day4
  module Part2
    class ScratchcardCounter
      attr_reader :sum

      def initialize
      end

      def self.count
        new.count
      end

      def count
        build_next_scratchcards_map
        build_copies_position_map
        build_total_num_of_scratchcard_by_order_map

        puts "Total scratchcards you end up with: #{@num_of_scratchcard_by_order.values.sum}"
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

      def init_scratchcard_reader(line)
        @scratchcard_reader = Day4::ScratchcardReader.new(line)
      end

      def total_matched_numbers
        scratchcard_reader.total_matched_numbers
      end

      def card_order_number
        scratchcard_reader.card_order_number
      end

      def next_scratchcard_order_numbers
        (1 .. total_matched_numbers).
          map { |n| card_order_number + n }.
          select { |n| n - 1 <= last_line_index }
      end

      def input_path
        File.join(File.dirname(__FILE__), '../input.txt')
      end

      private

      def build_next_scratchcards_map
        @next_scratchcards_map =
          lines.inject({}) do |h, line|
            init_scratchcard_reader(line)
            h[card_order_number] = next_scratchcard_order_numbers
            h
          end
      end

      def build_copies_position_map
        @copies_position_map =
          begin
            r = {}

            @next_scratchcards_map.each do |origin_scratchcard, _v|
              r[origin_scratchcard] = []

              @next_scratchcards_map.each do |k, next_won_scratchcards|
                if next_won_scratchcards.include?(origin_scratchcard)
                  r[origin_scratchcard] << k
                end
              end
            end

            r
          end
      end

      def build_total_num_of_scratchcard_by_order_map
        @num_of_scratchcard_by_order =
          @copies_position_map.keys.inject({}) do |h, order|
            previous_order = order - 1

            if previous_order.positive?
              h[order] =
                (1 .. previous_order).inject(1) do |temp, o|
                  @copies_position_map[order].include?(o) ? temp += h[o] : temp += 0
                  temp
                end
            else
              h[order] = 1
            end

            h
          end
      end
    end
  end
end
