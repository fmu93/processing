float rotate = PI/6;
float branchRatio = 0.5;

void setup() {
  size(1200, 800);
  background(255);
  

  stroke(0);
}
void draw() {
  background(255);
  translate(width/2, height);
  rotate = map(mouseX, 0, width, 0, PI);
  branchRatio = map(mouseY, 0, height, 0.2, 0.8);
  makeTree(height/2);
}

void makeTree(float l0) {
  if (l0 > 5) {
    strokeWeight(l0/50);
    line(0, 0, 0, -l0);
    translate(0, -l0);

    pushMatrix();
    rotate(rotate);
    makeTree(l0*branchRatio);
    popMatrix();

    pushMatrix();
    rotate(-rotate);
    makeTree(l0*branchRatio);
    popMatrix();
  }
}
