require_relative '../corrupted_memory_reader'

module Year2024
  module Day3
    module Part2
      class Answer
        def self.run
          new.run
        end

        def run
          corrupted_memory_reader.enabled_multiplication_instructions.each { |a| puts a.str }
          sum =
            corrupted_memory_reader.enabled_multiplication_instructions.inject(0) do |r, i|
              r += i.result
              r
            end

          puts "The sum results of multiplications: #{sum}"
        end

        def corrupted_memory_reader
          @corrupted_memory_reader ||= Year2024::Day3::CorruptedMemoryReader.new(filepath)
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
