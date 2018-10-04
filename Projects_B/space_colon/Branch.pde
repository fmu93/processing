class Branch {
  PVector pos;
  PVector dir;
  PVector saveDir;
  Branch parent;
  int count = 0;
  float len = 5;

  Branch(PVector pos0, PVector newDir) {
    pos = pos0.copy();
    dir = newDir.copy();
    saveDir = dir.copy();
  }

  Branch(Branch newParent) {
    parent = newParent;
    parent.dir.add(PVector.random3D().mult(0.3));
    parent.dir.setMag(len);
    pos = PVector.add(parent.pos, parent.dir);
    dir = parent.dir.copy();
    saveDir = parent.dir.copy(); //<>//
  }

  void reset() {
    count = 0;
    dir = saveDir.copy();
  }

  void show() {
    if (parent != null) {
      stroke(140, 80, 50);
      line(pos.x, pos.y, pos.z, parent.pos.x, parent.pos.y, parent.pos.z);
    }
  }
}
