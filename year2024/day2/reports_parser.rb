require_relative 'report'

module Year2024
  module Day2
    class ReportsParser
      attr_reader :input_filepath

      def initialize(input_filepath)
        @input_filepath = input_filepath
      end

      def parse
        File.foreach(input_filepath).inject([]) do |r, line|
          levels = line.strip.split.map(&:to_i)
          r << Year2024::Day2::Report.new(levels)
          r
        end
      end
    end
  end
end
