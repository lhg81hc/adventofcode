require_relative '../reports_parser'

module Year2024
  module Day2
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          reports = reports_parser.parse

          count =
            reports.inject(0) do |r, report|
              r += 1 if report.safe?
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
