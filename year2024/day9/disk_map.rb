module Year2024
  module Day9
    class DiskMap
      FREE_SPACE = '.'.freeze

      attr_reader :input_filepath

      def initialize(input_filepath)
        @input_filepath = input_filepath
      end

      def layout
        @layout ||=
          dense_format.chars.each.with_index.reduce([]) do |r, (_block_length, block_idx)|
            r += block_to_arr(block_idx)
            r
          end
      end

      def compact
        start_idx = 0
        end_idx = layout.length - 1

        r = []

        while start_idx <= end_idx
          char, start_idx, end_idx = swap_block_slot_if_needed(start_idx, end_idx)
          r << char unless char.nil?
        end

        r
      end

      def swap_block_slot_if_needed(start_idx, end_idx)
        return [layout[start_idx], start_idx + 1, end_idx] if layout[start_idx] != FREE_SPACE
        return [nil, start_idx, end_idx - 1] if layout[end_idx] == FREE_SPACE

        [layout[end_idx], start_idx + 1, end_idx - 1]
      end

      def calculate_checksum
        compact.each.with_index.inject(0) do |sum, (file_id, idx)|
          sum += file_id.to_i * idx
          sum
        end
      end

      def better_calculate_checksum
        start_idx = 0
        end_idx = layout.length - 1
        sum = 0

        while start_idx <= end_idx
          if layout[start_idx] != FREE_SPACE
            sum += start_idx * layout[start_idx].to_i
            start_idx += 1
            next
          end

          if layout[end_idx] == FREE_SPACE
            end_idx -= 1
            next
          end

          sum += start_idx * layout[end_idx].to_i
          end_idx -= 1
          start_idx += 1
        end

        sum
      end

      def best_calculate_checksum
        checksum = 0
        curr_idx = 0
        curr_block_idx = 0
        curr_file_block_replacement_idx =
          if file_block?(num_of_blocks - 1)
            (num_of_blocks - 1)
          else
            (num_of_blocks - 2) >= 0 ? (num_of_blocks - 2) : 0
          end
        num_of_unused_replacement = dense_format[curr_file_block_replacement_idx].to_i

        while curr_block_idx <= curr_file_block_replacement_idx
          if file_block?(curr_block_idx)
            if curr_block_idx != curr_file_block_replacement_idx
              dense_format[curr_block_idx].to_i.times do
                checksum += curr_idx * (curr_block_idx / 2)
                curr_idx += 1
              end
            else
              num_of_unused_replacement.times do
                checksum += curr_idx * (curr_file_block_replacement_idx / 2)
                curr_idx += 1
              end
            end
          end

          if free_space_block?(curr_block_idx)
            num_of_free_space_slots = dense_format[curr_block_idx].to_i

            while num_of_free_space_slots.positive?
              if num_of_unused_replacement.zero?
                if free_space_block?(curr_file_block_replacement_idx)
                  curr_file_block_replacement_idx -= 1

                  return checksum if curr_block_idx > curr_file_block_replacement_idx
                else # file_block? == true
                  num_of_unused_replacement = dense_format[curr_file_block_replacement_idx].to_i
                end
              else
                num_of_unused_replacement.times do
                  checksum += curr_idx * (curr_file_block_replacement_idx / 2)
                  curr_idx += 1
                  num_of_free_space_slots -= 1
                  num_of_unused_replacement -= 1

                  break if num_of_free_space_slots.zero?
                end

                if num_of_unused_replacement.zero?
                  curr_file_block_replacement_idx -= 2
                  num_of_unused_replacement = dense_format[curr_file_block_replacement_idx].to_i
                end

                return checksum if curr_block_idx > curr_file_block_replacement_idx
              end
            end
          end

          curr_block_idx += 1
        end

        checksum
      end

      def block_to_arr(idx)
        return file_block_to_arr(idx) if file_block?(idx)
        return free_space_block_to_arr(idx) if free_space_block?(idx)

        []
      end

      def file_id_by_index(idx)
        return nil unless file_block?(idx)

        idx / 2
      end

      def block_by_index(idx)
        valid_block_index?(idx) ? dense_format[idx] : nil
      end

      def num_of_blocks
        dense_format.length
      end

      def file_block?(idx)
        valid_block_index?(idx) && (idx.zero? || idx.even?)
      end

      def free_space_block?(idx)
        valid_block_index?(idx) && idx.odd?
      end

      def valid_block_index?(idx)
        idx >= 0 && idx < num_of_blocks
      end

      def dense_format
        @dense_format ||= File.open(input_filepath, &:readline).strip
      end

      private

      def file_block_to_arr(block_idx)
        block_length = block_by_index(block_idx)
        return '' if block_length.nil?

        file_id = file_id_by_index(block_idx)
        return '' if file_id.nil?

        Array.new(block_length.to_i, file_id.to_s)
      end

      def free_space_block_to_arr(block_idx)
        block_length = block_by_index(block_idx)
        return '' if block_length.nil?

        Array.new(block_length.to_i, FREE_SPACE)
      end
    end
  end
end
