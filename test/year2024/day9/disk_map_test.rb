require 'test/unit'
require_relative '../../../year2024/day9/disk_map'

module Year2024
  module Day9
    class DiskMapTest < Test::Unit::TestCase
      def setup
        @input_filepath = File.join(File.dirname(__FILE__), './input.txt')
        @disk_map = Year2024::Day9::DiskMap.new(@input_filepath)
      end

      def test_initialization
        assert_equal(@disk_map.input_filepath.to_s, @input_filepath.to_s)
      end

      def test_dense_format
        assert_equal(@disk_map.dense_format, '2333133121414131402')
      end

      def test_valid_block_index?
        assert(@disk_map.valid_block_index?(0))
        assert(@disk_map.valid_block_index?(18))
        refute(@disk_map.valid_block_index?(-1))
        refute(@disk_map.valid_block_index?(19))
        refute(@disk_map.valid_block_index?(-10))
        refute(@disk_map.valid_block_index?(100))
      end

      def test_free_space_block?
        assert(@disk_map.free_space_block?(1))
        assert(@disk_map.free_space_block?(7))

        refute(@disk_map.free_space_block?(-1))
        refute(@disk_map.free_space_block?(20))
        refute(@disk_map.free_space_block?(0))
        refute(@disk_map.free_space_block?(10))
      end

      def test_file_block?
        assert(@disk_map.file_block?(0))
        assert(@disk_map.file_block?(10))

        refute(@disk_map.file_block?(1))
        refute(@disk_map.file_block?(7))
        refute(@disk_map.file_block?(-1))
        refute(@disk_map.file_block?(20))
      end

      def test_numb_of_blocks
        assert_equal(@disk_map.num_of_blocks, 19)
      end

      def test_block_by_index
        assert_equal(@disk_map.block_by_index(0), "2")
        assert_equal(@disk_map.block_by_index(1), "3")
        assert_equal(@disk_map.block_by_index(18), "2")
        assert_nil(@disk_map.block_by_index(-1))
        assert_nil(@disk_map.block_by_index(19))
      end

      def test_file_id_by_index
        assert_equal(@disk_map.file_id_by_index(0), 0)
        assert_equal(@disk_map.file_id_by_index(2), 1)
        assert_equal(@disk_map.file_id_by_index(18), 9)
        assert_nil(@disk_map.file_id_by_index(1))
        assert_nil(@disk_map.file_id_by_index(-1))
        assert_nil(@disk_map.file_id_by_index(7))
      end

      def test_block_to_arr
        assert_equal(@disk_map.block_to_arr(0), ['0', '0'])
        assert_equal(@disk_map.block_to_arr(1), ['.', '.', '.'])
        assert_equal(@disk_map.block_to_arr(15), ['.'])
        assert_equal(@disk_map.block_to_arr(16), ['8', '8', '8', '8'])
        assert_equal(@disk_map.block_to_arr(17), [])
        assert_equal(@disk_map.block_to_arr(18), ['9', '9'])
      end

      def test_layout
        assert_equal(@disk_map.layout, '00...111...2...333.44.5555.6666.777.888899'.chars)
      end

      def test_compact
        assert_equal(@disk_map.compact, '0099811188827773336446555566'.chars)
      end

      def test_best_calculate_checksum
        assert_equal(@disk_map.best_calculate_checksum, 1928)
      end

      # def test_calculate_checksum_of_block_file
      #   assert_equal(@disk_map.calculate_check_sum_of_block_file(0, 0), 0)
      #   assert_equal(@disk_map.calculate_check_sum_of_block_file(5, 2), 18)
      # end
    end
  end
end
