require_relative '../my_math'
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

      def run
        # floyd_warshall = weighted_graph.floyd_warshall
        #
        # galaxy_pairs.each do |first_galaxy, second_galaxy|
        #   # first_galaxy_idx = vertex_index_map[first_galaxy.name]
        #   # second_galaxy_idx = vertex_index_map[second_galaxy.name]
        #
        #   key = "#{first_galaxy.name}<->#{second_galaxy.name}"
        #   same_meaning_key = "#{second_galaxy.name}<->#{first_galaxy.name}"
        #   next unless shortest_paths_between_galaxies[key].nil? && shortest_paths_between_galaxies[same_meaning_key].nil?
        #
        #   shortest_path = weighted_graph.a_star_2(first_galaxy, second_galaxy)
        #   shortest_path_length = shortest_path.count - 1
        #   puts "#{first_galaxy.name} - #{second_galaxy.name} => #{shortest_path_length}"
        #
        #   @sum += shortest_path_length
        #   @shortest_paths_between_galaxies[key] = shortest_path
        # end

        # start = weighted_graph.find_vertex_by_name('6,1')
        # goal = weighted_graph.find_vertex_by_name('11,5')
        # shortest_path = weighted_graph.a_star_2(start, goal)
        # puts shortest_path.count - 1
        # puts "Sum of the shortest paths between every pair of galaxies: #{sum}"
        puts galaxy_pairs.count
      end

      def image_scanner
        @image_scanner ||= Day11::ImageScanner.new(input_path)
      end

      def weighted_graph
        @weighted_graph ||= image_scanner.scan
      end

      def vertex_index_map
        @vertex_index_map ||=
          begin
            weighted_graph.vertices.each_with_index.inject({}) do |r, (v, idx)|
              r[v.name] = idx
              r
            end
          end
      end

      def galaxy_vertices
        @galaxy_vertices ||=
          begin
            galaxies = image_scanner.galaxies
            galaxy_keys = galaxies.map { |l| l.join(',') }
            weighted_graph.vertices.select { |v| galaxy_keys.include?(v.name) }
          end
      end

      def galaxy_pairs
        @galaxy_pairs ||= galaxy_vertices.combination(2)
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end
    end
  end
end
