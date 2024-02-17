require_relative 'vertex'
require_relative 'weighted_graph'

module Day11
  class ImageScanner
    GALAXY = '#'.freeze

    attr_reader :image_path

    def initialize(image_path)
      @image_path = image_path
    end

    def weighted_graph
      @weighted_graph ||= Day11::WeightedGraph.new
    end

    def input_path
      File.join(File.dirname(__FILE__), image_path)
    end

    def scan
      lines.each.with_index do |line, line_idx|
        line.scan(/[.|#]/).each.with_index do |char, char_idx|
          puts "Line #{line_idx}, Character #{char_idx}..."

          vertex = Day11::Vertex.new([line_idx, char_idx])
          horizontal_neighbor_locations = [[line_idx, char_idx + 1], [line_idx, char_idx - 1]]
          vertical_neighbor_locations = [[line_idx + 1, char_idx], [line_idx - 1, char_idx]]

          horizontal_neighbor_locations.each do |y, x|
            next if x < 0 || x >= width

            expansion = cols_contain_no_galaxies.include?(char_idx) ? 1 : 0
            expansion += 1 if cols_contain_no_galaxies.include?(x)

            weight = expansion + 1
            neighbor = Day11::Vertex.new([y, x])
            vertex.add_neighbor_and_weight(neighbor, weight)
          end

          vertical_neighbor_locations.each do |y, x|
            next if y < 0 || y >= height

            expansion = rows_contain_no_galaxies.include?(line_idx) ? 1 : 0
            expansion += 1 if rows_contain_no_galaxies.include?(y)

            weight = expansion + 1
            neighbor = Day11::Vertex.new([y, x])
            vertex.add_neighbor_and_weight(neighbor, weight)
          end

          weighted_graph.add_vertex(vertex)
        end
      end

      weighted_graph
    end

    def lines
      @lines ||=
        File.foreach(input_path).inject([]) do |r, line|
          r << line
          r
        end
    end

    def width
      @width ||= lines[0].strip.length
    end

    def height
      @height ||= lines.length
    end

    def rows_contain_no_galaxies
      @rows_contain_no_galaxies ||= rows_and_cols_contain_no_galaxies[0]
    end

    def cols_contain_no_galaxies
      @cols_contain_no_galaxies ||= rows_and_cols_contain_no_galaxies[1]
    end

    def rows_and_cols_contain_no_galaxies
      tmp_rows_contain_no_galaxies = (0..(height - 1)).to_a
      tmp_cols_contain_no_galaxies = (0..(width - 1)).to_a

      lines.each.with_index do |line, line_idx|
        line.scan(/[.|#]/).each.with_index do |char, char_idx|
          if char == GALAXY
            tmp_rows_contain_no_galaxies.delete_if { |x| x == line_idx }
            tmp_cols_contain_no_galaxies.delete_if { |x| x == char_idx }
          end
        end
      end

      [tmp_rows_contain_no_galaxies, tmp_cols_contain_no_galaxies]
    end
  end
end
