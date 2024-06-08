require 'test/unit'
require_relative '../../../year2022/day7/filesystem_node'

module Year2022
  module Day7
    class FilesystemNodeTest < Test::Unit::TestCase
      class RootDirectory < FilesystemNodeTest
        def setup
          @name = '/'
          @filesystem_node = Year2022::Day7::FilesystemNode.new(@name)
        end

        def test_root?
          assert(@filesystem_node.root?)
        end

        def test_directory?
          assert(@filesystem_node.directory?)
        end

        def test_file?
          refute(@filesystem_node.file?)
        end

        def test_size
          assert_nil(@filesystem_node.size)
        end

        def test_parent_node
          assert_nil(@filesystem_node.parent_node)
        end

        def test_parent_node=
          new_node = Year2022::Day7::FilesystemNode.new('tjtccqtm')
          assert_raises(ArgumentError) { @filesystem_node.parent_node = new_node }
        end

        def test_add_child_nodes
          assert_equal([], @filesystem_node.child_nodes)

          new_node = Year2022::Day7::FilesystemNode.new('tjtccqtm')
          @filesystem_node.add_child_nodes(new_node)

          assert_equal(1, @filesystem_node.child_nodes.length)
          assert_equal(new_node, @filesystem_node.child_nodes.first)
        end
      end

      class NonRootDirectory < FilesystemNodeTest
        def setup
          @name = 'llfdghs'
          @filesystem_node = Year2022::Day7::FilesystemNode.new(@name)
        end

        def test_root?
          refute(@filesystem_node.root?)
        end

        def test_directory?
          assert(@filesystem_node.directory?)
        end

        def test_file?
          refute(@filesystem_node.file?)
        end

        def test_size
          assert_nil(@filesystem_node.size)
        end

        def test_parent_node=
          assert_nil(@filesystem_node.parent_node)

          new_node = Year2022::Day7::FilesystemNode.new('/')
          @filesystem_node.parent_node = new_node

          assert_equal(new_node, @filesystem_node.parent_node)
        end

        def test_add_child_nodes
          assert_equal([], @filesystem_node.child_nodes)

          new_node = Year2022::Day7::FilesystemNode.new('tjtccqtm')
          @filesystem_node.add_child_nodes(new_node)

          assert_equal(1, @filesystem_node.child_nodes.length)
          assert_equal(new_node, @filesystem_node.child_nodes.first)
        end
      end

      class FileNode < FilesystemNodeTest
        def setup
          @name = 'fbhz.fbd'
          @filesize = 328535
          @filesystem_node = Year2022::Day7::FilesystemNode.new(@name, @filesize)
        end

        def test_root?
          refute(@filesystem_node.root?)
        end

        def test_directory?
          refute(@filesystem_node.directory?)
        end

        def test_file?
          assert(@filesystem_node.file?)
        end

        def test_size
          assert_equal(@filesize, @filesystem_node.size)
        end

        def test_parent_node=
          assert_nil(@filesystem_node.parent_node)

          new_node = Year2022::Day7::FilesystemNode.new('qsvh')
          @filesystem_node.parent_node = new_node

          assert_equal(new_node, @filesystem_node.parent_node)
        end

        def test_add_child_nodes
          new_node = Year2022::Day7::FilesystemNode.new('tjtccqtm')
          assert_raises(ArgumentError) { @filesystem_node.add_child_nodes(new_node) }
        end
      end
    end
  end
end
