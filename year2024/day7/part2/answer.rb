require_relative '../calibration_equation'

module Year2024
  module Day7
    module Part2
      class Answer
        def self.run
          new.run
        end

        def run
          sum = 0

          calibration_equations.each do |calibration_equation|
            if calibration_equation.adjustable_using_two_operators?
              sum += calibration_equation.test_value
              puts "#{calibration_equation.str} --> Valid"
            elsif calibration_equation.adjustable_using_three_operators?
              sum += calibration_equation.test_value
              puts "#{calibration_equation.str} --> Valid"
            else
              puts "#{calibration_equation.str} --> Invalid!!!"
            end
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
