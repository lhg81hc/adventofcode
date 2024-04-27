require_relative 'brick'

module Day22
  class SnapshotParser
    attr_reader :filepath

    def initialize(filepath)
      @filepath = filepath
    end

    def self.parse(filepath)
      new(filepath).parse
    end

    def parse
      File.foreach(filepath).with_index.reduce([]) do |r, (line, line_index)|
        brick_name = line_index + 1
        first_coordinates_set, second_coordinates_set = line.split('~').map { |s| s.split(',').map(&:to_i) }
        brick = Brick.new(brick_name.to_s, first_coordinates_set, second_coordinates_set)

        r << brick
        r
      end
    end
  end
end
