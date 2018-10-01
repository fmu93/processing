class CA {

  int[] cells;
  int generation;

  int[] ruleset;

  int w = 4;
  int back;


  CA(int[] set) {
    ruleset = set;
    cells = new int[width/w];
    restart();
    randomize();
  }

  void restart() {
    for (int i = 0; i < cells.length; i++) {
      cells[i] = 0;
    }
    cells[cells.length/2] = 1;
    generation = 0;
    back = (int) random(200, 255);
  }

  void randomize() {
    for (int i = 0; i < 8; i++) {
      ruleset[i] = int(random(2));
    }
  }

  void generate() {
    int[] nextgen = new int[cells.length];
    for (int i = 1; i < cells.length-1; i++) {
      int left = cells[i-1];
      int me = cells[i];
      int right = cells[i+1];
      nextgen[i] = applyrule(left, me, right);
    }
    cells = nextgen;
    generation++;
  }

  void display() {
    for (int i = 0; i < cells.length; i++) {
      if (cells[i] == 1) fill(0);
      else               fill(back);
      noStroke();
      rect(i*w, generation*w, w, w);
    }
  }


  int applyrule(int left, int me, int right) {

    if (left == 1 && me == 1 && right == 1) return ruleset[0];
    if (left == 1 && me == 1 && right == 0) return ruleset[1];
    if (left == 1 && me == 0 && right == 1) return ruleset[2];
    if (left == 1 && me == 0 && right == 0) return ruleset[3];
    if (left == 0 && me == 1 && right == 1) return ruleset[4];
    if (left == 0 && me == 1 && right == 0) return ruleset[5];
    if (left == 0 && me == 0 && right == 1) return ruleset[6];
    return ruleset[7];
  }
}
