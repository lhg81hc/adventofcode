require_relative 'hailstone'

module Day24
  class InputParser
    attr_reader :filepath

    def initialize(filepath)
      @filepath = filepath
    end

    def self.parse(filepath)
      new(filepath).parse
    end

    def parse
      File.foreach(filepath).with_index.inject([]) do |r, (line, line_idx)|
        name = (line_idx + 1).to_s
        position, velocity = parse_line(line)

        r << Day24::Hailstone.new(name, position, velocity)
      end
    end

    def parse_line(line)
      parts = line.split(' @ ')
      parts.map { |part| part.scan(/-?\d+/).map(&:to_i) }
    end
  end
end
