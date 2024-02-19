module Day11
  class WeightedGraph
    attr_reader :vertices, :edges

    def initialize(vertices = [])
      @vertices = vertices
    end

    def add_vertex(vertex)
      @vertices << vertex
    end

    def find_vertex_by_name(name)
      vertices.find { |v| v.name == name }
    end

    # https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
    def dijkstra(source_name)
      dist = {}
      q = []

      vertices.each do |vertex|
        dist[vertex.name] = Float::INFINITY
        q << vertex
      end

      dist[source_name] = 0

      until q.empty?
        min = nil
        u_idx = nil

        q.each.with_index do |vertex, idx|
          if min.nil?
            min = dist[vertex.name]
            u_idx = idx
            next
          end

          if dist[vertex.name] < min
            min = dist[vertex.name]
            u_idx = idx
          end
        end

        u = q.delete_at(u_idx)

        u.neighbors.each.with_index do |neighbor, neighbor_idx|
          next unless q.find { |v| v.name == neighbor.name }
          alt = dist[u.name] + u.weights[neighbor_idx]

          if alt < dist[neighbor.name]
            dist[neighbor.name] = alt
          end
        end
      end

      dist
    end

    def a_star(start, goal)
      dist = {}
      q = []

      vertices.each do |vertex|
        dist[vertex.name] = Float::INFINITY
        q << vertex
      end

      dist[start.name] = 0

      until q.empty?
        min = nil
        u_idx = nil

        q.each.with_index do |vertex, idx|
          if min.nil?
            min = dist[vertex.name]
            u_idx = idx
            next
          end

          if dist[vertex.name] < min
            min = dist[vertex.name]
            u_idx = idx
          end
        end

        u = q.delete_at(u_idx)
        return dist[u.name] if u.name == goal.name

        u.neighbors.each.with_index do |neighbor, neighbor_idx|
          next unless q.find { |v| v.name == neighbor.name }
          alt = dist[u.name] + u.weights[neighbor_idx]

          if alt < dist[neighbor.name]
            dist[neighbor.name] = alt
          end
        end
      end

      nil
    end

    def a_star_2(start, goal)
      open_set = [start]
      g_score = {}
      f_score = {}
      came_from = {}

      vertices.each do |vertex|
        g_score[vertex.name] = Float::INFINITY
        f_score[vertex.name] = Float::INFINITY
      end

      g_score[start.name] = 0
      f_score[start.name] = manhattan_distance(start, goal)

      until open_set.empty?
        min = nil
        min_idx = nil

        open_set.each.with_index do |vertex, idx|
          if min.nil?
            min = f_score[vertex.name]
            min_idx = idx
            next
          end

          if f_score[vertex.name] < min
            min = f_score[vertex.name]
            min_idx = idx
          end
        end

        current = open_set.delete_at(min_idx)
        # puts current.name
        return reconstruct_path(came_from, current) if current.name == goal.name

        # puts "neighbor count: #{current.neighbors.count}"
        current.neighbors.each.with_index do |neighbor, neighbor_idx|
          tentative_g_score = g_score[current.name] + current.weights[neighbor_idx]

          if tentative_g_score < g_score[neighbor.name]
            came_from[neighbor.name] = current
            g_score[neighbor.name] = tentative_g_score
            f_score[neighbor.name] = tentative_g_score + manhattan_distance(neighbor, goal)

            unless open_set.find { |v| v.name == neighbor.name }
              # puts "Adding #{neighbor.name}"
              open_set << vertices.find { |v| v.name == neighbor.name }
            end
          end
        end
      end

      raise 'Not found'
    end

    def floyd_warshall
      distance_matrix = []

      (0..vertices.length - 1).each do |line_idx|
        puts "Initializing Floyd Warshall row #{line_idx}..."
        current_vertex = vertices[line_idx]
        dist = {
          current_vertex.name => 0
        }
        current_vertex.neighbors.each.with_index do |n, n_idx|
          dist[n.name] = current_vertex.weights[n_idx]
        end

        row_data =
          vertices.map do |vertex|
            tmp_dist = dist[vertex.name]
            tmp_dist ||= Float::INFINITY
            tmp_dist
          end

        distance_matrix << row_data
      end

      max_idx = vertices.length

      for k in (0..max_idx - 1) do
        puts "Updating solution matrix loop #{k}"
        for i in (0..max_idx - 1) do
          for j in (0..max_idx - 1) do
            puts "i = #{i}, j = #{j}"
            if distance_matrix[i][j] > (distance_matrix[i][k] + distance_matrix[k][j]) && (distance_matrix[k][j] != Float::INFINITY && distance_matrix[i][k] != Float::INFINITY)
              distance_matrix[i][j] = distance_matrix[i][k] + distance_matrix[k][j]
            end
          end
        end
      end

      distance_matrix
    end

    private

    def reconstruct_path(came_from, current)
      total_path = [current.name]

      while came_from.keys.include?(current.name)
        current = came_from[current.name]
        total_path.prepend(current.name)
      end

      total_path
    end

    # https://simple.wikipedia.org/wiki/Manhattan_distance
    def manhattan_distance(from_vertex, to_vertex)
      (from_vertex.location[0] - to_vertex.location[0]).abs + (from_vertex.location[1] - to_vertex.location[1]).abs
    end
  end
end
