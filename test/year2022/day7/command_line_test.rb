require 'test/unit'
require_relative '../../../year2022/day7/command_line'

module Year2022
  module Day7
    class CommandLineTest < Test::Unit::TestCase
      class ChangeDirectoryCommand < CommandLineTest
        def setup
          @str = '$ cd tjtccqtm'
          @command_line = Year2022::Day7::CommandLine.new(@str)
        end

        def test_command_name
          assert_equal('cd', @command_line.command_name)
        end

        def test_command_type
          assert_equal(:change_directory, @command_line.command_type)
        end

        def test_change_directory_command?
          assert(@command_line.change_directory_command?)
        end

        def test_list_command?
          refute(@command_line.list_command?)
        end

        def test_target_directory_name
          assert_equal('tjtccqtm', @command_line.target_directory_name)
        end
      end

      class ListCommand < CommandLineTest
        def setup
          @str = '$ ls'
          @command_line = Year2022::Day7::CommandLine.new(@str)
        end

        def test_command_name
          assert_equal('ls', @command_line.command_name)
        end

        def test_command_type
          assert_equal(:list, @command_line.command_type)
        end

        def test_change_directory_command?
          refute(@command_line.change_directory_command?)
        end

        def test_list_command?
          assert(@command_line.list_command?)
        end

        def test_target_directory_name
          assert_nil(@command_line.target_directory_name)
        end
      end

      class BlankCommand < CommandLineTest
        def setup
          @str = ''
          @command_line = Year2022::Day7::CommandLine.new(@str)
        end

        def test_command_name
          assert_raises(ArgumentError) { @command_line.command_type }
        end

        def test_command_type
          assert_raises(ArgumentError) { @command_line.command_type }
        end

        def test_change_directory_command?
          assert_raises(ArgumentError) { @command_line.command_type }
        end

        def test_list_command?
          assert_raises(ArgumentError) { @command_line.command_type }
        end

        def test_target_directory_name
          assert_raises(ArgumentError) { @command_line.command_type }
        end
      end
    end
  end
end
