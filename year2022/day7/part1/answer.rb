require_relative '../filesystem'

module Year2022
  module Day7
    module Part1
      class Answer
        def initialize
          @filesystem = Year2022::Day7::Filesystem.new
        end

        def self.run
          new.run
        end

        def run
          File.foreach(filepath) do |line|
            @filesystem.browse(line.strip)
          end

          total =
            @filesystem.analyze_disk_usage.inject(0) do |sum, (_k, v)|
              sum += v if v < 100000
              sum
            end

          puts "The sum of the total sizes of all the directories with a total size of at most 100000: #{total}"
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
