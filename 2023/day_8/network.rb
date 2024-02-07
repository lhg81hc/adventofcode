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
  end
end
