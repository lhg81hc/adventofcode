require_relative '../assignment_pairs'

module Year2022
  module Day4
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          total =
            File.foreach(filepath).inject(0) do |s, line|
              assignment_pairs = Year2022::Day4::AssignmentPairs.new(line.strip)

              s += 1 if assignment_pairs.one_range_contain_the_other?
              s
            end

          puts "Total assignment pairs does one range fully contain the other: #{total}"
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
