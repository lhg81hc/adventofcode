require_relative 'node'

module Day8
  class Network

    attr_reader :filepath

    def initialize(filepath)
      @filepath = filepath
    end

    def map
      @map ||=
        File.foreach(filepath).with_index.reduce({}) do |r, (line, line_idx)|
          if line_idx > 1
            node = Day8::Node.new(line)

            r[node.value] = node
            r
          else
            r
          end
        end
    end

    def instructions
      @instructions ||=
        begin
          first_line = File.open(filepath, &:readline)
          first_line.scan(/\w/)
        end
    end

    def instructions_length
      @instructions_length ||= instructions.count
    end

    def find_node_after_num_of_steps(starting_node, starting_direction_idx, number_of_steps)
      count_step = 0
      idx = starting_direction_idx
      current_node = starting_node

      while count_step < number_of_steps
        count_step += 1

        direction = instructions[idx]
        next_value = current_node.turn(direction)
        current_node = map[next_value]

        if idx == instructions_length - 1
          idx = 0
        else
          idx += 1
        end
      end

      current_node
    end

    def find_next_node_ends_with_z(starting_node, starting_direction_idx)
      idx = starting_direction_idx
      number_of_next_steps = 0
      current_node = starting_node

      loop do
        number_of_next_steps += 1

        direction = instructions[idx]
        next_value = current_node.turn(direction)
        current_node = map[next_value]

        if idx == instructions_length - 1
          idx = 0
        else
          idx += 1
        end

        return [current_node, number_of_next_steps] if next_value.end_with?('Z')
      end
    end
  end
end
