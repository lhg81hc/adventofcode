require_relative 'diagram_component'
require_relative 'wiring_diagram'
require_relative 'nondirectional_connection'

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
      open_connections = []
      close_connections = []

      File.foreach(filepath) do |line|
        component_name, other_connected_component_names = parse_line(line)

        other_connected_component_names.each do |c_name|
          open_connection_idx = open_connections.index { |c| c.first_component.name == c_name }

          if open_connection_idx.nil?
            close_connection = NondirectionalConnection.new(DiagramComponent.new(component_name), DiagramComponent.new(c_name))
            close_connections << close_connection
          else
            open_connection = open_connections.delete_at(open_connection_idx)
            open_connection.add_second_component(DiagramComponent.new(component_name))

            open_connections << open_connection
          end
        end
      end

      puts "open_connections: #{open_connections.length}"
      Day25::WiringDiagram.new(close_connections)
    end

    private

    def parse_line(line)
      parts = line.split(':')
      component_name = parts[0]
      other_connected_component_names = parts[1].sub(': ', '').split

      [component_name, other_connected_component_names]
    end
  end
end
