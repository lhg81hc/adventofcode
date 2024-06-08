require_relative '../filesystem'
require_relative '../constants'

module Year2022
  module Day7
    module Part2
      class Answer
        include Constants

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

          disk_usage = @filesystem.analyze_disk_usage
          outermost_directory_size = disk_usage[ROOT_DIRECTORY_NAME]
          needed_delete_size = 30000000 - (70000000 - outermost_directory_size)
          found_directory_name = ROOT_DIRECTORY_NAME

          disk_usage.each do |directory_name, size|
            found_directory_name = directory_name if size >= needed_delete_size && size <= disk_usage[found_directory_name]
          end

          puts "The size of the smallest directory that, if deleted, would free up enough space on the " +
               "filesystem to run the update: #{disk_usage[found_directory_name]}"
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
