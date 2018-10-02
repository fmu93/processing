class Tree { //<>//
  ArrayList<Branch> branches = new ArrayList<Branch>();
  ArrayList<Leaf> leaves = new ArrayList<Leaf>();
  int nLeaves = 200;

  Tree() {
    for (int i = 0; i < nLeaves; i++) {
      leaves.add(new Leaf());
    }

    Branch root = new Branch(new PVector(width/2, height), new PVector(0, -1));
    branches.add(root);
    Branch current = new Branch(root);

    while (!closeEnough(current)) {
      Branch trunk = new Branch(current);
      branches.add(trunk);
      current = trunk;
    }
  }

  Boolean closeEnough(Branch branch) {
    for (Leaf leaf : leaves) {
      float d = PVector.dist(leaf.pos, branch.pos);
      if (d < max_dist) {
        return true;
      }
    }
    return false;
  }

  void grow() {
    // iterate thru leaves and branches
    for (Leaf l : leaves) {
      Branch closest = null;
      float record = 100000;

      for (Branch b : branches) {
        float d = PVector.dist(l.pos, b.pos);

        if (d < min_dist) {
          l.reached = true;
          closest = null;
          break;
        } else if (d < max_dist && (closest == null || d < record)) {
          closest = b;
          record = d;
        }

        if (closest != null) {
          PVector newDir = PVector.sub(l.pos, b.pos);
          closest.dir.add(newDir);
          closest.count++;
        }
      }
    }



    // iterate thru leaves and deleate reached ones
    for (int i = leaves.size() - 1; i >= 0; i--) {
      if (leaves.get(i).reached) {
        leaves.remove(i);
      }
    }

    // make new branches with direction if their near-leaf count is > 0
    for (int i = branches.size() - 1; i >= 0; i--) {
      Branch b = branches.get(i);
      if (b.count > 0) {
        b.dir.div(b.count);
        // direction could be randomized a bit
        branches.add(b.next());
      }
      b.reset();
    }
  }

  void show() {
    for (Leaf leaf : leaves) {
      leaf.show();
    }
    for (int i = 0; i < branches.size(); i++) {
      strokeWeight(map(i, 0, branches.size(), 5, 0));
      branches.get(i).show();
    }
  }
}
