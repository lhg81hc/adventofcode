require 'test/unit'
require_relative '../../../year2022/day7/filesystem.rb'

module Year2022
  module Day7
    class FilesystemTest < Test::Unit::TestCase
      def setup
        @lines = [
          '$ cd /',
          '$ ls',
          'dir a',
          '14848514 b.txt',
          '8504156 c.dat',
          'dir d',
          '$ cd a',
          '$ ls',
          'dir e',
          '29116 f',
          '2557 g',
          '62596 h.lst',
          '$ cd e',
          '$ ls',
          '584 i',
          '$ cd ..',
          '$ cd ..',
          '$ cd d',
          '$ ls',
          '4060174 j',
          '8033020 d.log',
          '5626152 d.ext',
          '7214296 k'
        ]

        @filesystem = Year2022::Day7::Filesystem.new
      end

      def test_browse
        assert_equal(@filesystem.root_node, @filesystem.current_node)

        @filesystem.browse(@lines[0])
        assert_equal(@filesystem.root_node, @filesystem.current_node)

        @filesystem.browse(@lines[1])
        assert_equal(@filesystem.root_node, @filesystem.current_node)
        assert_equal([], @filesystem.current_node.child_nodes)

        @filesystem.browse(@lines[2])
        assert_equal(@filesystem.root_node, @filesystem.current_node)
        assert_equal(1, @filesystem.current_node.child_nodes.length)
        assert_equal(['a'], @filesystem.current_node.child_nodes.map(&:to_s))
        assert_equal([nil], @filesystem.current_node.child_nodes.map(&:size))

        @filesystem.browse(@lines[3])
        assert_equal(@filesystem.root_node, @filesystem.current_node)
        assert_equal(2, @filesystem.current_node.child_nodes.length)
        assert_equal(['a', 'b.txt'], @filesystem.current_node.child_nodes.map(&:to_s))
        assert_equal([nil, 14848514], @filesystem.current_node.child_nodes.map(&:size))

        @filesystem.browse(@lines[4])
        assert_equal(@filesystem.root_node, @filesystem.current_node)
        assert_equal(3, @filesystem.current_node.child_nodes.length)
        assert_equal(['a', 'b.txt', 'c.dat'], @filesystem.current_node.child_nodes.map(&:to_s))
        assert_equal([nil, 14848514, 8504156], @filesystem.current_node.child_nodes.map(&:size))

        @filesystem.browse(@lines[5])
        assert_equal(@filesystem.root_node, @filesystem.current_node)
        assert_equal(4, @filesystem.current_node.child_nodes.length)
        assert_equal(['a', 'b.txt', 'c.dat', 'd'], @filesystem.current_node.child_nodes.map(&:to_s))
        assert_equal([nil, 14848514, 8504156, nil], @filesystem.current_node.child_nodes.map(&:size))

        @filesystem.browse(@lines[6])
        assert_equal('a', @filesystem.current_node.name)
        assert_equal(0, @filesystem.current_node.child_nodes.length)

        @filesystem.browse(@lines[7])
        assert_equal('a', @filesystem.current_node.name)
        assert_equal(0, @filesystem.current_node.child_nodes.length)

        @filesystem.browse(@lines[8])
        assert_equal('a', @filesystem.current_node.name)
        assert_equal(1, @filesystem.current_node.child_nodes.length)
        assert_equal(['e'], @filesystem.current_node.child_nodes.map(&:to_s))
        assert_equal([nil], @filesystem.current_node.child_nodes.map(&:size))

        @filesystem.browse(@lines[9])
        assert_equal('a', @filesystem.current_node.name)
        assert_equal(2, @filesystem.current_node.child_nodes.length)
        assert_equal(['e', 'f'], @filesystem.current_node.child_nodes.map(&:to_s))
        assert_equal([nil, 29116], @filesystem.current_node.child_nodes.map(&:size))

        @filesystem.browse('$ cd ..')
        assert_equal(@filesystem.root_node, @filesystem.current_node)
      end

      def test_analyze_disk_usage
        @lines.each { |line| @filesystem.browse(line) }

        assert_equal({ '/' => 48381165, '/a' => 94853, '/a/e' => 584, '/d' => 24933642 }, @filesystem.analyze_disk_usage)
      end
    end
  end
end
