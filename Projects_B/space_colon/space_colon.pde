import peasy.*;

Tree tree;
PeasyCam cam;

//float min_dist = 30;
//float max_dist = 80;

float min_dist = 80;
float max_dist = 150;

void setup() {
  size(1500, 1000, P3D);
  frameRate(40);
  tree = new Tree();
  cam = new PeasyCam(this, height);
}

void draw() {
  background(40);

  tree.show();
  tree.grow();
}

void mouseClicked() {
  tree = new Tree();
}
