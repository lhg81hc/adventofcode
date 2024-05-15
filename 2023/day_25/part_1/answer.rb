require_relative '../wiring_diagram_parser'

module Day25
  module Part1
    class Answer
      def self.run
        new.run
      end

      def run
        # wiring_diagram.connections.each do |c|
        #   puts "#{c.first_component.name}, #{c.second_component.name}"
        # end

        puts wiring_diagram.connections.count
      end

      def wiring_diagram
        @wiring_diagram ||= Day25::WiringDiagramParser.parse(filepath)
      end

      def filepath
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
