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
      bricks = []

      File.foreach(filepath).with_index do |line, line_index|
        brick_name = line_index + 1
        first_coordinates_set, second_coordinates_set = line.split('~').map { |s| s.split(',').map(&:to_i) }

        bricks << Day22::Brick.new(brick_name, first_coordinates_set, second_coordinates_set)
      end

      bricks
    end
  end
end
