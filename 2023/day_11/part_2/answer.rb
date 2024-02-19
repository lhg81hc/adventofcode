require_relative '../image_scanner'

module Day11
  module Part2
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

      def run
        galaxy_pairs.each do |first_galaxy, second_galaxy|
          key = "#{first_galaxy.join(',')}<->#{second_galaxy.join(',')}"
          same_meaning_key = "#{second_galaxy.join(',')}<->#{first_galaxy.join(',')}"
          next unless shortest_paths_between_galaxies[key].nil? && shortest_paths_between_galaxies[same_meaning_key].nil?

          shortest_path = image_scanner.shortest_distance_between_galaxies(first_galaxy, second_galaxy)
          puts "#{first_galaxy.join(',')} - #{second_galaxy.join(',')} => #{shortest_path}"

          @sum += shortest_path
          @shortest_paths_between_galaxies[key] = shortest_path
        end

        puts "Sum of the shortest paths between every pair of galaxies: #{sum}"
      end

      def image_scanner
        @image_scanner ||= Day11::ImageScanner.new(input_path, expansion: 1000000)
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
