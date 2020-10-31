int[][] board = new int[7][6];
color boardColour = color(127);
color emptyColour = color(100);
color player1Colour = color(255, 255, 0);
color player2Colour = color(255, 0, 0);
color player1Ghost = lerpColor(player1Colour, emptyColour, 0.5);
color player2Ghost = lerpColor(player2Colour, emptyColour, 0.5);
int[] ghost = {0, 5};
int turn = 1; // 1 is first player, 2 is second player

void setup() {
  size(840, 720);
  noStroke();
  //ellipseMode(CORNER);
  for (int i = 0; i < 7; i++) {
    for (int j = 0; j < 6; j++) {
      board[i][j] = 0;
    }
  }
}

void draw() {
  background(boardColour);
  for (int i = 0; i < 7; i++) {
    for (int j = 0; j < 6; j++) {
      if (ghost[0] == i && ghost[1] == j) {
        if (turn == 1) {
          fill(player1Ghost);
        } else {
          fill(player2Ghost);
        }
      } else if (board[i][j] == 1) {
        fill(player1Colour);
      } else if (board[i][j] == 2) {
        fill(player2Colour);
      } else {
        fill(emptyColour);
      }
      ellipse(i*120+60, j*120+60, 100, 100);
    }
  }
  
  ghost[0] = floor(mouseX/120);
  if (board[ghost[0]][0] != 0) {
    ghost[1] = -1;
  } else if (board[ghost[0]][1] != 0) {
    ghost[1] = 0;
  } else if (board[ghost[0]][2] != 0) {
    ghost[1] = 1;
  } else if (board[ghost[0]][3] != 0) {
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
  if (ghost[1] >= 0) {
    board[ghost[0]][ghost[1]] = turn;
    turn = turn % 2 + 1;
  }
}
