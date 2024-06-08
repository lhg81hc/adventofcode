require_relative 'constants'

module Year2022
  module Day7
    class CommandLine
      include Constants

      attr_reader :str

      def initialize(str)
        @str = str
      end

      def command_name
        split_string[1]
      end

      def command_type
        case command_name
        when CD_COMMAND
          :change_directory
        when LS_COMMAND
          :list
        else
          raise ArgumentError, "Unknown command: #{str.inspect}"
        end
      end

      def change_directory_command?
        command_type == :change_directory
      end

      def list_command?
        command_type == :list
      end

      def target_directory_nanme
        return nil unless change_directory_command?

        split_string[-1]
      end

      private

      def split_string
        @split_string ||= str.split(' ')
      end
    end
  end
end
