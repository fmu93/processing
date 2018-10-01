class GOL {
  int w = 10;
  int rows, cols;
  int board[][];
  int n = int(random(200, 800));

  GOL() {
    rows = height/w;
    cols = width/w;
    board = new int[cols][rows];
    reset();
  }

  void reset() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j<rows; j++) {
        board[i][j] = 0;
      }
    }
    
    for (int r = 0; r<n; r++) {
      board[int(random(cols))][int(random(rows))] = 1;
    }

  }

  void generate() {
    int[][] nextgen = new int[cols][rows];

    for (int x = 1; x < cols-1; x++) {
      for (int y = 1; y < rows-1; y++) {

        int neighbors = 0;
        for (int i = -1; i<2; i++) {
          for (int j = -1; j<2; j++) {
            neighbors += board[x+i][y+j];
          }
        }
        neighbors -= board[x][y];

        if (board[x][y] == 1 && neighbors > 3) nextgen[x][y] = 0; // overpopulation
        else if (board[x][y] == 1 && neighbors < 2) nextgen[x][y] = 0; // loneliness
        else if (board[x][y] == 0 && neighbors == 3) nextgen[x][y] = 1; // birth
        else nextgen[x][y] = board[x][y];
      }
    }
    board = nextgen;
  }

  void display() {
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        if (board[x][y] == 1) fill(0);
        else fill(255);

        rect(x*w, y*w, w, w);
      }
    }
  }
}
