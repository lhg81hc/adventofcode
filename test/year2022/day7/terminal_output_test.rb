require 'test/unit'
require_relative '../../../year2022/day7/terminal_output'

module Year2022
  module Day7
    class TerminalOutputTest < Test::Unit::TestCase
      class DirectoryString < TerminalOutputTest
        def setup
          @output = 'dir tjtccqtm'
          @terminal_output = Year2022::Day7::TerminalOutput.new(@output)
        end

        def test_file?
          refute(@terminal_output.file?)
        end

        def test_directory?
          assert(@terminal_output.directory?)
        end

        def test_entity_name
          assert_equal('tjtccqtm', @terminal_output.entity_name)
        end

        def test_entity_size
          assert_nil(@terminal_output.entity_size)
        end
      end

      class FileString < TerminalOutputTest
        def setup
          @output = '205103 ntpprbt.pvt'
          @terminal_output = Year2022::Day7::TerminalOutput.new(@output)
        end

        def test_file?
          assert(@terminal_output.file?)
        end

        def test_directory?
          refute(@terminal_output.directory?)
        end

        def test_entity_name
          assert_equal('ntpprbt.pvt', @terminal_output.entity_name)
        end

        def test_entity_size
          assert_equal(205103, @terminal_output.entity_size)
        end
      end

      class BlankString < TerminalOutputTest
        def setup
          @output = ''
          @terminal_output = Year2022::Day7::TerminalOutput.new(@output)
        end

        def test_file?
          refute(@terminal_output.file?)
        end

        def test_directory?
          refute(@terminal_output.directory?)
        end

        def test_entity_name
          assert_nil(@terminal_output.entity_name)
        end

        def test_entity_size
          assert_nil(@terminal_output.entity_size)
        end
      end
    end
  end
end
