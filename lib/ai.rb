require 'paint'
require 'pry'

module AI
  DEPTH = 3

  # Choose move by best outcome:
  def computer_chooses_movement
    possible_moves = board.generate_moves(:black).shuffle
    # will have: possible_moves << castling if castling_rights?

    eva = {} # Test
    best_move = possible_moves.min_by do |move|
                  evaluation = minimax(move, DEPTH, -Float::INFINITY, Float::INFINITY, false)
                  store_evaluation(eva, move, evaluation) # Test
                  evaluation
                end
    binding.pry
    return possible_moves.sample if all_equal?(eva)
    best_move
  end

  def minimax(move, depth, alpha, beta, maximizing_player)
    return board.evaluate if depth.zero? # or checkmate for (white or black)

    if maximizing_player
      # Best is relative: best for the enemy
      best_evaluation = Float::INFINITY

      # This performs the passed in move:
      start_position, target_position = move
      piece_buffer = board[target_position]
      board.move_piece!(start_position, target_position)

      # This generates children:
      board.generate_moves(:black).each do |move| 
        evaluation = minimax(move, depth - 1, alpha, beta, false)
        best_evaluation = [best_evaluation, evaluation].min
        beta = [beta, evaluation].min
        break if beta <= alpha
      end

      board.move_piece!(target_position, start_position)
      board[target_position] = piece_buffer

      best_evaluation
    else
      # Best is relative: best for the enemy
      best_evaluation = -Float::INFINITY

      # This performs the passed in move:
      start_position, target_position = move
      piece_buffer = board[target_position]
      board.move_piece!(start_position, target_position)

      # This generates children:
      board.generate_moves(:white).each do |move| 
        evaluation = minimax(move, depth - 1, alpha, beta, true)
        best_evaluation = [best_evaluation, evaluation].max
        alpha = [alpha, evaluation].max
        break if beta <= alpha
      end

      board.move_piece!(target_position, start_position)
      board[target_position] = piece_buffer

      best_evaluation
    end
  end

  # Testing:
  def store_evaluation(evaluations, move, evaluation)
    description = format(
      "%s %s to %s %s",
      board[move.first].class,
      move.first,
      board[move.last].class,
      move.last
    )
    evaluations[description] = evaluation
  end

  def all_equal?(evaluations)
    first_value = evaluations.values.first
    evaluations.values.all? { |value| value == first_value }
  end

  # Testing:
  def move_generation_test(color, depth)    
    return 1 if depth.zero?

    possible_moves = generate_moves(color)

    number_positions = 0
    
    color = swap_color(color)
    possible_moves.each do |(start_position, target_position)|
      move_piece!(start_position, target_position) if !self[target_position].is_a?(NullPiece)
      number_positions += move_generation_test(color, depth - 1)
      move_piece!(target_position, start_position) if !self[target_position].is_a?(NullPiece)
    end

    number_positions
  end
end