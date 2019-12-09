require_relative "../skeleton/lib/00_tree_node.rb"
require "byebug"
class KnightPathFinder
  # hello

  #takes in a pos, and returns true/false if move is valid. (fits into our board)
  def self.valid_move?(pos) #[8,8] => false #[1,7]=> true
    return false if pos[0] > 7 || pos[1] > 7 ||  pos[0] < 0 || pos[1] < 0
    true 
  end

  def self.valid_move(pos) #[8,8] => false #[1,7]=> true
      funcs = [[-2,-1], [-2,1], [2,-1], [2,1], [-1,-2], [1,-2], [-1,2], [1,2]]
      moves = funcs.map { |func| [(pos[0] + func[0]), (pos[1] + func[1])] } 
      moves.select! { |pos| KnightPathFinder.valid_move?(pos) }
      # moves.map! { |node| PolyTreeNodem.new(node) }
      moves
  end
  
  attr_reader :root_node
  attr_accessor :considered_positions

  def initialize(pos)
    @root_node = PolyTreeNode.new(pos)
    @considered_positions = [pos]
    self.build_move_tree
  end

  def new_move_positions(pos)
    moves = KnightPathFinder.valid_move(pos)
    # debugger
    new_moves = moves.reject { |pos| self.considered_positions.include?(pos) }
    self.considered_positions += new_moves 
    new_moves
  end


  
  def build_move_tree
    queue = [self.root_node] 
    # debugger
    # until queue.empty?
   
    # node_pos = possible_moves.map { |pos| PolyTreeNode.new(pos) }
    until queue.empty?
      el = queue.shift 
      possible_moves = new_move_positions(el.value)
      
      possible_moves.each do |pos|
        node = PolyTreeNode.new(pos)
        node.parent = el 
        queue << node
      end
    end
  end

  def find_path(end_pos)
    trace_path_back(self.root_node.bfs(end_pos))
  end
  
  def trace_path_back(node)
    path = [node]
    until path.first.value == self.root_node.value
      path.unshift(path[0].parent)
    end
    path.map { |node| node.value }
  end
end




if $PROGRAM_NAME == __FILE__
board = KnightPathFinder.new([1,1])
p board.find_path([3, 2]) 
p board.find_path([7, 4]) 
end
# board.build_move_tree
# p board.new_move_positions([0,0])

# p board.considered_positions
# p board.new_move_positions([0,0])
# pos = PolyTreeNode.new([])
# p board.build_move_tree([0,0]).sort


