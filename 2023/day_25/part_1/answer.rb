require_relative '../wiring_diagram_parser'

module Day25
  module Part1
    class Answer
      # def initialize
      #
      # end

      def self.run
        new.run
      end

      def run
        puts wiring_diagram.list.last.name
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