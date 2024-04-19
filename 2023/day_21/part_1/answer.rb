require_relative '../garden_map_builder'

module Day21
  module Part1
    class Answer
      def self.run
        new.run
      end

      def run
        starting_component = garden_map.find_component_by_char('S')
        starting_component.adjacent_components.each do |adjacent_component|
          puts "#{adjacent_component.location} -> #{adjacent_component.char}"
        end
      end

      def garden_map
        @garden_map ||= Day21::GardenMapBuilder.build(filepath)
      end

      def filepath
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
