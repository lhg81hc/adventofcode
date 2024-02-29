require_relative '../platform_panel'
require_relative '../platform_panel_controller'

module Day14
  module Part1
    class Answer
      INPUT_FILE = '../input.txt'

      attr_reader :sum

      def initialize
        @sum = 0
      end

      def self.run
        new.run
      end

      def run
        tilted_platform_panel = platform_panel_controller.tilt_north

        tilted_platform_panel.rows.each do |row|
          puts row.map(&:char).join
          length = row.length

          row.each.with_index do |component, component_idx|
            next unless component.rounded_rock?
            @sum += length - component_idx
          end
        end

        puts "The total load on the north support beams: #{sum}"
      end

      def platform_panel
        @platform_panel ||= Day14::PlatformPanel.new(lines)
      end

      def platform_panel_controller
        @platform_panel_controller ||= Day14::PlatformPanelController.new(platform_panel)
      end

      def lines
        @lines ||=
          File.open(input_path).inject([]) do |r, line|
            r << line.strip
            r
          end
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end
    end
  end
end
