import peasy.*;

Tree tree;
PeasyCam cam;

float min_dist = 15;
float max_dist = 70;

void setup() {
  size(1000, 1000, P3D);
  //frameRate(20);
  tree = new Tree();
  cam = new PeasyCam(this, 700);
  
  stroke(255);
  strokeWeight(2);
}

void draw() {
  background(40);

  tree.show();
  tree.grow();
}

void mouseClicked() {
 tree = new Tree(); 
}
