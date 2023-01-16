# Sapphire Chess

Sapphire Chess is a command line-based chess game with an algebraic notation input system,
complete chess rules, a beautiful interface and a functional AI. It provides three game modes: 
Human vs. Human, Human vs. AI, and AI vs. AI.

Please, visit https://medium.com/@lucas.sorribes/nostromo-my-ruby-chess-journey-part-i-7ef544b547a5 for a very detailed account of how I wrote this game.

Supported Rubies: 3.1, 3.0, 2.7. 
The game has not been tested for older versions, but it might still work.

---

## Current Features

* A beautiful board with easy-to-distinguish colors for white and black pieces.
* Fully functional AI
* Three levels of difficulty.
* Three game modes: human vs. computer, human vs. human.
* Full chess movement rules implementation, including castling and *en passant*, for both the human and the computer player.
* Accepts algebraic notation for movements, with human input validation.
* Material score display.
* Player's last move display.

## Setup

Install with:
```ruby
gem install 'saphhire-chess'
```
And execute from the command prompt with:
```
sapphire-chess
```
Currently, the icons are only loaded properly from within VS Code terminals, so, for the moment, I highly recommend executing this command from there.

You can also create a new `.rb` file with this content and execute it:
```ruby
require 'sapphire-chess'

Engine.new.play
```

## Difficulty Mode

The difficulty mode is based on how many turns the computer can think ahead (the depth of the tree generated by `AI#minimax`, max. 3), the aggressiveness of the pieces, and the enemy's carelessness.

My recommendation is to play the game on the *hard* mode, as this was the original intention when I designed it. I introduced the other difficulties based on the suggestions from those who weren't able to beat the machine. However, the hard mode, due to the current Minimax implementation, is a little slow; I'm working on ways to improve the performance of this method.

## Screenshot

![Game screenshot](https://live.staticflickr.com/65535/52630422741_bc858d0096_z.jpg)

## The AI

The AI is based on a Minimax algorithm with Alpha-Beta pruning. This algorithm generates possible outcomes (*children*) for a provisional move: Each branch represents the enemy's possible move in the next turn as an answer to the provisional move; (i.e.: if current player is white [the maximizing player], it generates every possible movement for the next player, black [the minimizing player], who will choose the best possible move, and so on. 

The best (relative to each player) possible outcome for each move will determine what move is chosen) The Alpha-Beta 'prunes' the tree: it makes the search more efficient, removing unnecessary branches, resulting in a faster process.

Copyright © 2023 Lucas Sorribes, released under the MIT license.


