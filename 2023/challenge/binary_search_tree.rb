require_relative 'tree_node'

module Challenge
  class BinarySearchTree
    attr_accessor :root

    def initialize(val)
      @root = TreeNode.new(val, nil, nil)
    end

    def insert(val)
      # Idea:
      # 1. Travel from root down
      # 2. When val > current node go right
      # 3. When val < current node go left
      # 4. If there is no more child node to check, create a new node

      curr_node = @root

      while curr_node
        if val < curr_node.val
          if curr_node.left.nil?
            curr_node.left = TreeNode.new(val, nil, nil)
          else
            curr_node = curr_node.left
          end
        elsif val > curr_node.val
          if curr_node.right.nil?
            curr_node.right = TreeNode.new(val, nil, nil)
          else
            curr_node = curr_node.right
          end
        else
          return nil
        end
      end
    end

    def pre_order_traversal(node = @root)
      # 1. Start from root
      # 2. Then visit left node
      # 3. Then visit right node
      return if node.nil?

      puts node.val
      pre_order_traversal(node.left)
      pre_order_traversal(node.right)
    end

    def in_order_traversal(node = @root)
      # 1. Start from left node
      # 2. Then visit root
      # 3. Then visit right node
      return if node.nil?

      pre_order_traversal(node.left)
      puts node.val
      pre_order_traversal(node.right)
    end

    def post_order_traversal(node = @root)
      # 1. Start from left node
      # 2. Then visit right node
      # 3. Then visit root node
      return if node.nil?

      pre_order_traversal(node.left)
      pre_order_traversal(node.right)
      puts node.val
    end

    def level_order_traversal(node = @root)
      (1..height(node)).each do |level|
        puts_current_level(node, level)
      end

      nil
    end

    def puts_current_level(node, level)
      return if node.nil?

      if level == 1
        puts node.val
      elsif level > 1
        puts_current_level(node.left, level - 1)
        puts_current_level(node.right, level - 1)
      end
    end

    def height(node)
      return 0 if node.nil?

      left_height = height(node.left)
      right_height = height(node.right)

      if left_height > right_height
        left_height + 1
      else
        right_height + 1
      end
    end
  end
end
