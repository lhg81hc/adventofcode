require_relative '../calibration_equation'

module Year2024
  module Day7
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          sum = 0

          calibration_equations.each do |calibration_equation|
            puts "Testing #{calibration_equation.str}..."

            sum += calibration_equation.test_value if calibration_equation.adjustable?
          end

          puts sum
        end

        def calibration_equations
          @calibration_equations ||=
            File.foreach(filepath).inject([]) do |r, line|
              r << Year2024::Day7::CalibrationEquation.new(line.strip)
              r
            end
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
