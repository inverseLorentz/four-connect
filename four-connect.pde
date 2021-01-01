int[][] board = new int[7][6]; // 0 = empty, 1 = player 1's piece, 2 = player 2's piece

color boardColour = color(127);
color emptyColour = color(100);

color player1Colour = color(255, 255, 0);
color player2Colour = color(255, 0, 0);
color player3Colour = color(0, 255, 0);
color player4Colour = color(255, 0, 255);

color player1Ghost = lerpColor(player1Colour, emptyColour, 0.5);
color player2Ghost = lerpColor(player2Colour, emptyColour, 0.5);
color player3Ghost = lerpColor(player3Colour, emptyColour, 0.5);
color player4Ghost = lerpColor(player4Colour, emptyColour, 0.5);

int[] ghost = {0, 5}; // where the "ghost" (shadow of where the piece will be placed if clicked) is
int turn = 1; // 1 is first player, 2 is second player, etc.
int players = 2; // change this for the amount of players in game (maximum 4)
boolean win = false; // true if someone has won

void setup() {
  size(840, 720);
  noStroke();
  
  // initialise board to all empty
  for (int i = 0; i < 7; i++) {
    for (int j = 0; j < 6; j++) {
      board[i][j] = 0;
    }
  }
}

void draw() {
  background(boardColour);
  
  // draw board
  for (int i = 0; i < 7; i++) {
    for (int j = 0; j < 6; j++) {
      // colours
      if (ghost[0] == i && ghost[1] == j) {
        // draw ghost
        if (turn == 1) {
          fill(player1Ghost);
        } else if (turn == 2) {
          fill(player2Ghost);
        } else if (turn == 3) {
          fill(player3Ghost);
        } else {
          fill(player4Ghost);
        }
      } else if (board[i][j] == 1) {
        fill(player1Colour);
      } else if (board[i][j] == 2) {
        fill(player2Colour);
      } else if (board[i][j] == 3) {
        fill(player3Colour);
      } else if (board[i][j] == 4) {
        fill(player4Colour);
      } else {
        fill(emptyColour);
      }
      ellipse(i*120+60, j*120+60, 100, 100);
    }
  }
  
  // set ghost position
  ghost[0] = floor(mouseX/120); // x coordinate purely based on mouse x coordinate
  if (board[ghost[0]][0] != 0 || win) { // if the top of the column the mouse is over is filled (therefore entire column filled) OR if someone has won
    ghost[1] = -1; // this makes ghost not visible on screen and disables a move being made
  } else if (board[ghost[0]][1] != 0) { // if top of column is unfilled, but rest of column is filled
    ghost[1] = 0; // ghost at top of column
  } else if (board[ghost[0]][2] != 0) { // if top two places in the column are unfilled, but rest of column is filled
    ghost[1] = 1; // ghost at second highest of column
  } else if (board[ghost[0]][3] != 0) { // etc.
    ghost[1] = 2;
  } else if (board[ghost[0]][4] != 0) {
    ghost[1] = 3;
  } else if (board[ghost[0]][5] != 0) {
    ghost[1] = 4;
  } else {
    ghost[1] = 5;
  }
}

void mouseReleased() {
  if (ghost[1] >= 0) { // if column is not filled
    board[ghost[0]][ghost[1]] = turn; // put piece at where the ghost is
    turn = turn % players + 1; // cycle turn around number of players
  }
  
  // win detection
  
  // horizontal check
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 6; j++) {
      if (board[i][j] != 0) {
        if (board[i][j] == board[i+1][j] && board[i][j] == board[i+2][j] && board[i][j] == board[i+3][j]) {
          win = true;
        }
      }
    }
  }
  
  // vertical check
  for (int i = 0; i < 7; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] != 0) {
        if (board[i][j] == board[i][j+1] && board[i][j] == board[i][j+2] && board[i][j] == board[i][j+3]) {
          win = true;
        }
      }
    }
  }
  
  // diagonal \ check
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] != 0) {
        if (board[i][j] == board[i+1][j+1] && board[i][j] == board[i+2][j+2] && board[i][j] == board[i+3][j+3]) {
          win = true;
        }
      }
    }
  }
  
  // diagonal / check
  for (int i = 0; i < 4; i++) {
    for (int j = 3; j < 6; j++) {
      if (board[i][j] != 0) {
        if (board[i][j] == board[i+1][j-1] && board[i][j] == board[i+2][j-2] && board[i][j] == board[i+3][j-3]) {
          win = true;
        }
      }
    }
  }
}
