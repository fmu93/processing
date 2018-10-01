class KochLine {

  PVector start;
  PVector end;

  KochLine(PVector s, PVector e) {
    start = s;
    end = e;
  }
  
  void wiggle() {
   PVector wig = PVector.random2D();
   wig.setMag(0.4);
   start.add(wig); 
  }

  ArrayList<PVector> get5points() {
    ArrayList<PVector> points = new ArrayList<PVector>();
    points.add(start);

    PVector b = PVector.sub(end, start);
    b.div(3);
    PVector c = b.copy();
    PVector d = b.copy();
    b.add(start);
    points.add(b);

    c.rotate(-PI/3);
    c.add(b);
    points.add(c);
    
    points.add(PVector.sub(end, d));
    points.add(end);

    return points;
  }
  
  void display() {
   line(start.x, start.y, end.x, end.y); 
    
  }

}
