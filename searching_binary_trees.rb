class Node
  attr_accessor :value, :parent, :left_child, :right_child

  def initialize(value, parent=nil)
    @value = value
    @parent = parent
    @left_child = nil
    @right_child = nil
  end
end

class BinarySearchTree

  attr_accessor :root

  def initialize
    @root = nil
    #@pointer = nil
  end

  public

  def build_tree(array)
    @root = Node.new(array.shift)
    array.each do |data|
      place_node(@root, data)
    end
  end

  def breadth_first_search(value)
    queue = []
    queue << @root
    until queue.empty?
      node = queue.shift
      if node.value == value
        return node
      else
        queue << node.left_child unless node.left_child.nil?
        queue << node.right_child unless node.right_child.nil?
      end
    end
    nil
  end

  def depth_first_search(value)
    stack = []
    stack << @root
    until stack.empty?
      node = stack.pop
      if node.value == value
        return node
      else
        stack << node.right_child unless node.right_child.nil?
        stack << node.left_child unless node.left_child.nil?
      end
    end
    nil
  end

  def dfs_rec(value, node = @root)
    if node.nil? || node.value == value
      return node
    else
      pointer = dfs_rec(value, node.left_child)
      pointer = dfs_rec(value, node.right_child) if pointer.nil?
      pointer
    end
  end

  private

  def place_node(parent_node, value)
    if parent_node.nil?
      return Node.new(value)
    end

    if parent_node.value > value
      parent_node.left_child = place_node(parent_node.left_child, value)
      parent_node.left_child.parent = parent_node
    else
      parent_node.right_child = place_node(parent_node.right_child, value)
      parent_node.right_child.parent = parent_node
    end
  end


end


array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = BinarySearchTree.new
tree.build_tree(array)

a = tree.breadth_first_search(8).parent.value
puts a
b = tree.depth_first_search(8).parent.value
puts b
c = tree.dfs_rec(8).parent.value
puts c