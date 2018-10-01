int[][] generations;
int resolution = 10;
int cols;
int rows;
byte ruleset;
CA ca;

void setup() {
  size(800, 600);
  background(200);
  frameRate(40);
  int[] ruleset = {0, 1, 1, 1, 1, 0, 0, 1};

  cols = width/resolution;
  rows = height/resolution;

  ca = new CA(ruleset);
}

void draw() {
  ca.display();
  ca.generate();
  
  if (ca.generation*ca.w > height) {
   ca.restart();
   ca.randomize();
  }
}
