require_relative 'command_line'
require_relative 'constants'
require_relative 'filesystem_node'
require_relative 'terminal_output'

module Year2022
  module Day7
    class Filesystem
      include Constants

      attr_reader :root_node, :current_node

      def initialize
        @root_node = Year2022::Day7::FilesystemNode.new(ROOT_DIRECTORY_NAME)
        @current_node = @root_node
      end

      def browse(line)
        if command_line?(line)
          command_line = Year2022::Day7::CommandLine.new(line)
          execute_command(command_line)
          return
        end

        if terminal_output?(line)
          terminal_output_line = Year2022::Day7::TerminalOutput.new(line)
          save_terminal_output(terminal_output_line)
          return
        end

        nil
      end

      def analyze_disk_usage
        r = {}
        post_traversal(root_node, nil, r)
        r
      end

      def execute_command(command_line)
        change_directory(command_line.target_directory_name) if command_line.change_directory_command?
      end

      def save_terminal_output(terminal_output_line)
        node = Year2022::Day7::FilesystemNode.new(terminal_output_line.entity_name, terminal_output_line.entity_size, @current_node)

        @current_node.add_child_nodes(node)
      end

      private

      def find_node(directory_name)
        case directory_name
        when ROOT_DIRECTORY_NAME
          @root_node
        when PARENT_DIRECTORY_INDICATOR
          if @current_node.root?
            @root_node
          else
            @current_node.parent_node
          end
        else
          @current_node.child_nodes.find { |node| node.name == directory_name }
        end
      end

      def command_line?(str)
        str.start_with?(COMMAND_LINE_PREFIX)
      end

      def terminal_output?(str)
        str.start_with?(DIR_PREFIX) || str[0].match?(DIGIT_MATCH_REGEX)
      end

      def change_directory(directory_name)
        target_node = find_node(directory_name)
        raise ArgumentError, "Directory #{directory_name} is not found" unless target_node

        @current_node = target_node
      end

      def post_traversal(node, parent_directory, result)
        current_full_path = directory_full_path(parent_directory, node.to_s)
        result[current_full_path] ||= 0

        node.child_nodes.each do |child_node|
          if child_node.directory?
            post_traversal(child_node, current_full_path, result)
            child_full_path = directory_full_path(current_full_path, child_node.to_s)

            puts child_full_path
            result[current_full_path] += result[child_full_path]
          end

          if child_node.file?
            result[current_full_path] += child_node.size
          end
        end
      end

      def directory_full_path(parent_directory, current_directory)
        if parent_directory.nil?
          ROOT_DIRECTORY_NAME
        elsif parent_directory == ROOT_DIRECTORY_NAME
          parent_directory + current_directory
        else
          [parent_directory, current_directory].join('/')
        end
      end
    end
  end
end
