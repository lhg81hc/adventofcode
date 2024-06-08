require_relative 'constants'

module Year2022
  module Day7
    class TerminalOutput
      include Constants

      attr_reader :str

      def initialize(str)
        @str = str
      end

      def file?
        !str.empty? && !directory_prefix?
      end

      def directory?
        directory_prefix?
      end

      def entity_name
        split_str[-1]
      end

      def entity_size
        return nil unless file?
        str.split(' ').first.to_i
      end

      private

      def directory_prefix?
        str.start_with?(DIR_PREFIX)
      end

      def split_str
        @split_str ||= str.split(' ')
      end
    end
  end
end
