require_relative 'brick'
require_relative 'snapshot_perspective'

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
      snapshot_perspective = Day22::SnapshotPerspective.new

      File.foreach(filepath).with_index.reduce([]) do |r, (line, line_index)|
        brick_name = line_index + 1
        first_coordinates_set, second_coordinates_set = line.split('~').map { |s| s.split(',').map(&:to_i) }

        snapshot_perspective.add_brick(Day22::Brick.new(brick_name, first_coordinates_set, second_coordinates_set))
      end

      snapshot_perspective
    end
  end
end
