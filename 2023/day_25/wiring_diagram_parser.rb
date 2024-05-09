require_relative 'diagram_component'
require_relative 'wiring_diagram'

module Day25
  class WiringDiagramParser
    attr_reader :filepath

    def initialize(filepath)
      @filepath = filepath
    end

    def self.parse(filepath)
      new(filepath).parse
    end

    def parse
      File.foreach(filepath).inject(Day25::WiringDiagram.new) do |r, line|
        r.add_component(parse_line(line))
        r
      end
    end

    private

    def parse_line(line)
      parts = line.split(':')
      component_name = parts[0]
      other_connected_component_names = parts[1].sub(': ', '').split

      Day25::DiagramComponent.new(component_name, other_connected_component_names)
    end
  end
end
