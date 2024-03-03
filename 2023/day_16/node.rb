module Day16
  class Node
    attr_reader :val, :successors

    def initialize(val)
      @val = val
      @successors = []
    end

    def add_edge(successor)
      @successors << successor
    end

    def to_s
      "#{val} -> [#{successors.map(&:name).join(' ')}]"
    end
  end
end
