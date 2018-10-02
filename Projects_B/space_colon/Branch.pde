class Branch {
  PVector pos;
  PVector dir;
  PVector saveDir;
  Branch parent;
  int count = 0;
  float len = 10;

  Branch(PVector pos0, PVector newDir) {
    pos = pos0.copy();
    dir = newDir.copy();
    saveDir = dir.copy();
  }

  Branch(Branch newParent) {
    parent = newParent;
    pos = PVector.add(parent.pos, parent.dir);
    dir = parent.dir.copy();
    saveDir = dir.copy();
  }

  Branch next() {
    Branch nextBranch = new Branch(this);
    nextBranch.dir.mult(len);
    return nextBranch;
  }

  void reset() {
    count = 0;
    dir = saveDir.copy();
  }

  void show() {
    if (parent != null) {
      line(pos.x, pos.y, parent.pos.x, parent.pos.y);
    }
  }
}
