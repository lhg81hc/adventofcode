require_relative 'vertex'
require_relative 'weighted_graph'

module Day11
  class ImageScanner
    GALAXY = '#'.freeze

    attr_reader :input_path, :expansion

    def initialize(input_path, expansion: 2)
      @input_path = input_path
      @expansion = expansion
    end

    def weighted_graph
      @weighted_graph ||= Day11::WeightedGraph.new
    end

    def expanded_image
      @expanded_image ||=
        begin
          tmp = lines.dup

          row_count = 0
          rows_contain_no_galaxies.each do |row_idx|
            tmp.insert(row_idx + row_count, '.' * original_width)
            row_count += 1
          end

          tmp.each.with_index do |line, line_idx|
            tmp_line = line.dup
            char_count = 0

            cols_contain_no_galaxies.each do |col_idx|
              tmp_line.insert(col_idx + char_count, '.')
              char_count += 1
            end

            tmp[line_idx] = tmp_line
          end

          tmp
        end
    end

    def scan
      lines.each.with_index do |line, line_idx|
        line.scan(/[.|#]/).each.with_index do |_char, char_idx|
          vertex = Day11::Vertex.new([line_idx, char_idx])
          neighbor_locations = [
            [line_idx, char_idx + 1],
            [line_idx, char_idx - 1],
            [line_idx + 1, char_idx],
            [line_idx - 1, char_idx]
          ]

          neighbor_locations.each do |y, x|
            next if x < 0 || x >= original_width || y < 0 || y >= original_height

            neighbor = Day11::Vertex.new([y, x])
            vertex.add_neighbor_and_weight(neighbor, 1)
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
      @width ||= expanded_image[0].strip.length
    end

    def height
      @height ||= expanded_image.length
    end

    def original_width
      @original_width ||= lines[0].strip.length
    end

    def original_height
      @original_height ||= lines.length
    end

    def rows_contain_no_galaxies
      @rows_contain_no_galaxies ||= rows_and_cols_contain_no_galaxies[0]
    end

    def cols_contain_no_galaxies
      @cols_contain_no_galaxies ||= rows_and_cols_contain_no_galaxies[1]
    end

    def galaxies
      @galaxies ||=
        begin
          tmp = []

          lines.each.with_index do |line, line_idx|
            line.scan(/[.|#]/).each.with_index do |char, char_idx|
              if char == GALAXY
                tmp << [line_idx, char_idx]
              end
            end
          end

          tmp
        end
    end

    def rows_and_cols_contain_no_galaxies
      tmp_rows_contain_no_galaxies = (0..(original_height - 1)).to_a
      tmp_cols_contain_no_galaxies = (0..(original_width - 1)).to_a

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

    def shortest_distance_between_galaxies(first_galaxy, second_galaxy)
      height_between_galaxies(first_galaxy, second_galaxy) + width_between_galaxies(first_galaxy, second_galaxy)
    end

    def height_between_galaxies(first_galaxy, second_galaxy)
      height = (first_galaxy[0] - second_galaxy[0]).abs
      min_height, max_height = [first_galaxy[0], second_galaxy[0]].sort

      num_of_rows_contain_no_galaxies =
        (min_height..max_height).inject(0) do |count, line_idx|
          count += 1 if rows_contain_no_galaxies.include?(line_idx)
          count
        end

      height - num_of_rows_contain_no_galaxies + (num_of_rows_contain_no_galaxies * expansion)
    end

    def width_between_galaxies(first_galaxy, second_galaxy)
      width = (first_galaxy[1] - second_galaxy[1]).abs
      min_width, max_width = [first_galaxy[1], second_galaxy[1]].sort

      num_of_cols_contain_no_galaxies =
        (min_width..max_width).inject(0) do |count, row_idx|
          count += 1 if cols_contain_no_galaxies.include?(row_idx)
          count
        end

      width - num_of_cols_contain_no_galaxies + (num_of_cols_contain_no_galaxies * expansion)
    end
  end
end
