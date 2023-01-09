class King < Piece
  MOVE_DIRECTIONS = [
    [0, 1], [1, 1], [1, 0], [0, -1],
    [1, -1], [-1, 1], [-1, -1], [-1, 0]
  ]
  
  BLACK = '♚'
  WHITE = '♔'

  VALUE = 20000

  WHITE_LOCATION_VALUE = [
    [-30,-40,-40,-50,-50,-40,-40,-30],
    [-30,-40,-40,-50,-50,-40,-40,-30],
    [-30,-40,-40,-50,-50,-40,-40,-30],
    [-30,-40,-40,-50,-50,-40,-40,-30],
    [-20,-30,-30,-40,-40,-30,-30,-20],
    [-10,-20,-20,-20,-20,-20,-20,-10],
    [20, 20,  0,  0,  0,  0, 20, 20],
    [20, 30, 10,  0,  0, 10, 30, 20]
  ]

  BLACK_LOCATION_VALUE = [
    [20, 30, 10, 0, 0, 10, 30, 20],
    [20, 20, 0, 0, 0, 0, 20, 20],
    [-10, -20, -20, -20, -20, -20, -20, -10],
    [-20, -30, -30, -40, -40, -30, -30, -20],
    [-30, -40, -40, -50, -50, -40, -40, -30],
    [-30, -40, -40, -50, -50, -40, -40, -30],
    [-30, -40, -40, -50, -50, -40, -40, -30],
    [-30, -40, -40, -50, -50, -40, -40, -30]
  ]

  WHITE_LOCATION_VALUE_END = [
    [-50,-40,-30,-20,-20,-30,-40,-50],
    [-30,-20,-10,  0,  0,-10,-20,-30],
    [-30,-10, 20, 30, 30, 20,-10,-30],
    [-30,-10, 30, 40, 40, 30,-10,-30],
    [-30,-10, 30, 40, 40, 30,-10,-30],
    [-30,-10, 20, 30, 30, 20,-10,-30],
    [-30,-30,  0,  0,  0,  0,-30,-30],
    [-50,-30,-30,-30,-30,-30,-30,-50]
  ]

  BLACK_LOCATION_VALUE_END = [
    [-50, -30, -30, -30, -30, -30, -30, -50], 
    [-30, -30, 0, 0, 0, 0, -30, -30], 
    [-30, -10, 20, 30, 30, 20, -10, -30], 
    [-30, -10, 30, 40, 40, 30, -10, -30], 
    [-30, -10, 30, 40, 40, 30, -10, -30], 
    [-30, -10, 20, 30, 30, 20, -10, -30], 
    [-30, -20, -10, 0, 0, -10, -20, -30], 
    [-50, -40, -30, -20, -20, -30, -40, -50]
  ]

  include StepPattern
  include CastlingPieceControl

  def initialize(board, location, color)
    super
    @moved = false
  end

  def location_value
    row, column = location

    if board.end_game? && color == :white
      self.class::WHITE_LOCATION_VALUE_END[row][column]
    elsif board.end_game? && color == :black
      self.class::BLACK_LOCATION_VALUE_END[row][column]
    elsif !board.end_game? && color == :white
      self.class::WHITE_LOCATION_VALUE[row][column]
    else
      self.class::BLACK_LOCATION_VALUE[row][column]
    end
  end
end