require_relative '../workflow'
require_relative '../machine_part_ratings'

module Day19
  module Part1
    class Answer
      INPUT_FILE = '../input.txt'.freeze
      START_WORKFLOW_NAME = 'in'.freeze

      def initialize
        @sum = 0
      end

      def self.run
        new.run
      end

      def run
        machine_part_rating_list.each do |machine_part_ratings|
          @sum += machine_part_ratings.sum if examine_machine_part(machine_part_ratings) == 'A'
        end

        puts "\n"
        puts "All of the rating numbers for all of the parts that ultimately get accepted: #{@sum}"
      end


      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end

      def workflows
        @workflows ||=
          File.open(input_path).inject({}) do |r, line|
            striped_line = line.strip
            break r if striped_line.empty?

            workflow = Day19::Workflow.new(striped_line)
            r[workflow.name] = workflow
            r
          end
      end

      def machine_part_rating_list
        @machine_part_rating_list ||=
          File.open(input_path).inject([]) do |r, line|
            striped_line = line.strip

            if striped_line.start_with?('{')
              r << Day19::MachinePartRatings.new(striped_line)
            end

            r
          end
      end

      def examine_machine_part(part)
        str = "#{part.val}: "
        str += START_WORKFLOW_NAME

        curr_workflow = workflows[START_WORKFLOW_NAME]
        next_workflow_name = curr_workflow.examine_machine_part(part)

        until next_workflow_name == 'A' || next_workflow_name == 'R'
          str += " -> #{next_workflow_name}"

          curr_workflow = workflows[next_workflow_name]
          next_workflow_name = curr_workflow.examine_machine_part(part)
        end

        str += " -> #{next_workflow_name}"
        puts str

        next_workflow_name
      end
    end
  end
end
