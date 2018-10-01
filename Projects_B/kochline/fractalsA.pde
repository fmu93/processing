PVector start;
PVector end;

ArrayList<KochLine> lines = new ArrayList<KochLine>();

void setup() {
  size(1000, 400);
  background(250);
  start = new PVector(0, height*0.8);
  end = new PVector(width, height*0.8);

  lines.add(new KochLine(start, end));
}

void draw() {
  background(250);
  stroke(0);
  strokeWeight(1);
  //midTriangle(start, end);
  for (KochLine line : lines) {
    line.display();
    if (mousePressed) {
      line.wiggle();
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    generate();
  } else if (key == 'c') {
    lines.clear();
    start = new PVector(0, height*0.8);
    end = new PVector(width, height*0.8);
    lines.add(new KochLine(start, end));
  }
}

void generate() {
  ArrayList<KochLine> next = new ArrayList<KochLine>();
  for (KochLine l : lines) {
    ArrayList<PVector> ps = l.get5points();

    next.add(new KochLine(ps.get(0), ps.get(1)));
    next.add(new KochLine(ps.get(1), ps.get(2)));
    next.add(new KochLine(ps.get(2), ps.get(3)));
    next.add(new KochLine(ps.get(3), ps.get(4)));
  }
  lines = next;
}
