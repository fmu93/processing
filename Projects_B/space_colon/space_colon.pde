Tree tree;
float min_dist = 10;
float max_dist = 80;

void setup() {
  size(1000, 1000);
  //frameRate(20);
  tree = new Tree();
  stroke(255, 150);
  strokeWeight(2);
}

void draw() {
  background(60);

  tree.show();
  tree.grow();
}

void mouseClicked() {
 tree = new Tree(); 
}
