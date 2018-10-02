class Leaf {
  PVector pos;
  Boolean reached = false;

  Leaf() {
    pos = PVector.random2D();
    pos.mult(random(width/3));
    pos.add(width/2, height/2);
  }

  void show() {
    ellipse(pos.x, pos.y, 4, 4);
  }
}
