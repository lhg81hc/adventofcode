module Day11
  class MyMath
    def dijkstra(weighted_graph, source_name)
      dist = {}
      prev = {}
      q = []

      weighted_graph.vertices.each do |vertex|
        dist[vertex.name] = Float::INFINITY
        prev[vertex.name] = nil
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
            prev[neighbor.name] = u
          end
        end

        a = 1

      end

      [dist, prev]
    end

    def reconstruct_path(came_from, current)
      total_path = [current]

      while came_from.keys.include?(current)
        current = came_from[current]
        total_path.prepend(current)
      end

      total_path
    end

    def a_star(start, goal, h)
      open_set = [start]
      came_from = {}
      g_score = {}
      g_score[start] = 0

      f_score = {}
      # f_score[start] =
    end
  end
end
