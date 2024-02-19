require_relative '../image_scanner'

module Day11
  module Part1
    class Answer
      INPUT_FILE = '../input.txt'

      attr_reader :sum, :shortest_paths_between_galaxies

      def initialize
        @sum = 0
        @shortest_paths_between_galaxies = {}
      end

      def self.run
        new.run
      end

      def height_between_galaxies(first_galaxy, second_galaxy)
        height = (first_galaxy[0] - second_galaxy[0]).abs
        min_height, max_height = [first_galaxy[0], second_galaxy[0]].sort

        num_of_rows_contain_no_galaxies =
          (min_height..max_height).inject(0) do |count, line_idx|
            count += 1 if image_scanner.rows_contain_no_galaxies.include?(line_idx)
            count
          end

        height - num_of_rows_contain_no_galaxies + (num_of_rows_contain_no_galaxies * 2)
      end

      def width_between_galaxies(first_galaxy, second_galaxy)
        width = (first_galaxy[1] - second_galaxy[1]).abs
        min_width, max_width = [first_galaxy[1], second_galaxy[1]].sort

        num_of_cols_contain_no_galaxies =
          (min_width..max_width).inject(0) do |count, row_idx|
            count += 1 if image_scanner.cols_contain_no_galaxies.include?(row_idx)
            count
          end

        width - num_of_cols_contain_no_galaxies + (num_of_cols_contain_no_galaxies * 2)
      end

      def run
        galaxy_pairs.each do |first_galaxy, second_galaxy|
          key = "#{first_galaxy.join(',')}<->#{second_galaxy.join(',')}"
          same_meaning_key = "#{second_galaxy.join(',')}<->#{first_galaxy.join(',')}"
          next unless shortest_paths_between_galaxies[key].nil? && shortest_paths_between_galaxies[same_meaning_key].nil?

          shortest_path = height_between_galaxies(first_galaxy, second_galaxy) + width_between_galaxies(first_galaxy, second_galaxy)
          puts "#{first_galaxy.join(',')} - #{second_galaxy.join(',')} => #{shortest_path}"

          @sum += shortest_path
          @shortest_paths_between_galaxies[key] = shortest_path
        end

        puts "Sum of the shortest paths between every pair of galaxies: #{sum}"
      end

      def image_scanner
        @image_scanner ||= Day11::ImageScanner.new(input_path)
      end

      def galaxy_pairs
        @galaxy_pairs ||= image_scanner.galaxies.combination(2)
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end
    end
  end
end
