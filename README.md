# Chess

## Description
Command line version of the classic board game, written in Ruby.

## Features
- Allows players to navigate the board and select pieces with a WASD cursor
- Multiple levels of class inheritance keeps code DRY

## Gameplay Instructions:
1. Use W-A-S-D to move the cursor, and press ENTER to select a piece.
2. Press ENTER on one of the available moves (highlighted in light blue) to perform the move.
3. Players will alternate turns.

## Screenshots
- Possible moves are highlighted in light blue
  ![highlight]

- When capturing an opponent piece is possible, the square is highlighted in red
  ![available_moves]

- The game ends when there are no possible moves for the opponent
  ![checkmate]

## To Run:
1. Download zip [here](http://github.com/kushkp/Chess/archive/master.zip) or click "Download ZIP" in the right sidebar.
2. Unzip and navigate to the 'chess' folder in the terminal
3. Run 'bundle install', then run 'ruby chess.rb'


[highlight]: './docs/initial.png'
[available_moves]: './docs/capture.png'
[checkmate]: './docs/gameover.png'
