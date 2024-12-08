require_relative '../reports_parser'

module Year2024
  module Day2
    module Part2
      class Answer
        def self.run
          new.run
        end

        def run
          reports = reports_parser.parse

          count =
            reports.inject(0) do |r, report|
              if report.safe_without_any_bad_levels_or_with_a_single_bad_level?
                r += 1
                puts "[#{report.levels.join(', ')}] is SAFE"
              else
                puts "[#{report.levels.join(', ')}] is NOT SAFE"
              end
              r
            end

          puts "The number of safe reports: #{count}"
        end

        def reports_parser
          @reports_parser ||= Year2024::Day2::ReportsParser.new(filepath)
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
