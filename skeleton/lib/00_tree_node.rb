class PolyTreeNode

  attr_reader :parent, :children, :value 
  # attr_accessor :parent
  def initialize(value)
    @value = value 
    @parent = nil 
    @children = []
  end

  def parent=(passed_node)
    self.parent.children.delete(self) unless self.parent.nil? 
    if passed_node
      @parent = passed_node 
      passed_node.children << self #unless passed_node.children.include?(self) NOT NEEDED IF YOU UNDERSTAND ON LINE 13 
    else 
      @parent = passed_node
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end
  
  def remove_child(child_node)
    raise "The node is not a child" if child_node.parent.nil?
    child_node.parent = nil 
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child| 
      search = child.dfs(target_value) 
      return search unless search.nil?
    end
    
    nil
  end

  def bfs(target_value)
    queue = [self]
        until queue.empty?
      peek = queue.shift
      peek.value == target_value ? (return peek) : queue += peek.children
    end
    nil
  end

end