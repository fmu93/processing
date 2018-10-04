class Leaf {
  PVector pos;
  Boolean reached = false;
  float size = 8;

  Leaf() {
    pos = PVector.random3D();
    pos.mult(random(10, width/3));
    //pos.add(width/2, height/2);
  }

  void show() {
    noStroke();
    if (reached) fill(20, 210, 40);
    else fill(20, 210, 40, 70);
    
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    ellipse(0, 0, size/3, size);
    rotateY(HALF_PI);
    ellipse(0, 0, size/3, size);
    popMatrix();
  }
}
