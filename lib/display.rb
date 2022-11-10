module Display
  def display_turn_number
    print Paint["   Turn #{turn_number.to_i}    ", nil, :green]
  end

  def display_player_turn
    puts Paint[
      "It's #{current_player.color}'s turn!",
      nil,
      current_player.color,
      :bright
    ]
  end

  def display_graphic_score
    [:black, :white].each do |color|
      message = case color
                when :white then Paint['White player score', :white, :underline]
                else Paint['Black player score', :blue, :underline]
                end
      print message + ': '
      display_pieces_score(color)
      puts "\n\n"
    end
  end

  def display_pieces_score(color)
    [Pawn, Knight, Bishop, Rook, Queen, King].each do |type|
      piece_symbol = get_piece_symbol(color, type)

      score_line = if type == Queen
                     "#{piece_symbol} x "\
                     "#{board.count(type, color) + board.promoted_pawns(color)} "
                   elsif type == Pawn
                     "#{piece_symbol} x "\
                     "#{board.count(type, color) - board.promoted_pawns(color)} "
                   else 
                     "#{piece_symbol} x #{board.count(type, color)} "
                   end

      print score_line unless score_line[-2] == "0"
    end
  end

  def get_piece_symbol(color, type)
    if type == Pawn
      if color == :white then Paint[type::WHITE.first, :white]
      else Paint[type::BLACK.first, :blue]
      end
    else
      if color == :white then Paint[type::WHITE, :white]
      else Paint[type::BLACK, :blue]
      end
    end
  end

  def display_check
    puts Paint['You are in check!', :red, :bright]
  end

  def display_checkmate
    puts Paint['Checkmate!', nil, :red, :bright]
    puts ''
  end

  def display_winner
    puts Paint[
      "#{current_player.color.to_s.capitalize} player wins!",
      nil,
      current_player.color
    ]
    puts 'Thanks for playing Ruby Chess'
  end
end
