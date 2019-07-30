class PatternSystem {

  //ArrayList<Particle> particles = new ArrayList<Particle>();
  PVector[] flowField;
  int maxCount = 200;
  float res;
  int cols;
  int rows;
  float zoff = random(100);
  float zoff2 = random(100);
  float incSpread = 0.0002;
  boolean debug = false;
  float[] colorSpread = {1.7, 0.5};  //[center, range/2]

  PatternSystem() {
    //particles = new ArrayList<Particle>();
    res = ledSize;
    //cols = floor(width/res*0.9);
    //rows = floor(height/res*0.9);
    //flowField = new PVector[(cols*rows)];
  }

  void evolveSpread() {
    //colorSpread[0] = map(mouseX, 0, width, 0, TWO_PI);
    //colorSpread[1] = map(mouseY, 0, height, 0, 8);

    colorSpread[0] = (colorSpread[0] + 0.0003) % 1.0;
    colorSpread[1] = (colorSpread[1] + incSpread);
    //colorSpread[1] = map(mouseY, 0, height, 0,4*PI);
    if (colorSpread[1] < 0 || colorSpread[1] > 1.8) incSpread = incSpread*-1;
    
  }

  float updateLookup(PVector _pos) {

    float xoff = (_pos.x / res)*incFlow;
    float yoff = (_pos.y / res)*incFlow;

    float minRange = colorSpread[0] - colorSpread[1];
    float maxRange = colorSpread[0] + colorSpread[1];
    float theta = map(noise(xoff, yoff, zoff), 0, 1, minRange, maxRange) % 1.0;
    return theta;
  }

  float brightnessLookup(PVector _pos) {

    float xoff = (_pos.x / res)*incFlow2;
    float yoff = (_pos.y / res)*incFlow2;

    float bri = noise(xoff, yoff, zoff2);

    return bri;
  }

  void updateFlowField() {
    evolveSpread();

    float yoff = 0;
    for (int y = 0; y < rows; y++) {
      float xoff = 0;
      for (int x = 0; x < cols; x++) {
        int index = (x+y*cols);

        float minRange = colorSpread[0] - colorSpread[1];
        float maxRange = colorSpread[0] + colorSpread[1];
        float theta = map(noise(xoff, yoff, zoff), 0, 1, minRange, maxRange);
        PVector v = PVector.fromAngle(theta);
        v.setMag(0.01); // TODO play around here

        flowField[index] = v;

        xoff = xoff + incFlow;
      }
      yoff = yoff + incFlow;
    }
    zoff = zoff + rateFlow;
  }
  
  void updateZ() {
    zoff = zoff + rateFlow;
    zoff2 = zoff2 + rateFlow2;
  }

  void showFlowField() {
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        int index = (x+y*cols);
        PVector v = flowField[index];

        if (debug) {
          strokeWeight(3);
          pushMatrix();
          translate(x*res, y*res);
          rotate(v.heading());
          stroke(color(map(v.heading(), -PI, PI, 0, 360), 100, 100, 30));
          line(0, 0, res, 0);
          popMatrix();
        }

        IntList ids = ledSystem.isInside(new PVector(x*res, y*res));

        if (ids != null && ids.size()>0) {
          for (int id : ids) {
            ledSystem.getLed(id).setColor(color(map(v.heading(), -PI, PI, 0, 360), 100, 100));
            //ledSystem.getLed(id).show(c);
          }
        }
      }
    }
  }

  PVector lookup(PVector pos) {
    int x = floor(pos.x / res);
    int y = floor(pos.y / res);
    int index = (x+y*cols);
    return flowField[index];
  }
/**
  void matrix() {
    if (particles.size() < maxCount && frameCount % 5 == 0) {
      Particle _part = new Particle(new PVector(random(width), 0));
      _part.size = random(ledSize, ledSize*4);
      _part.setColor(color(random(80, 140), 100, 100));
      _part.maxSpeed *= random(0.8, 2);
      particles.add(_part);
    }

    for (int i = particles.size()-1; i >= 0; i--) {
      Particle part = particles.get(i);

      if (part.pos.y > height) {
        particles.remove(i);
        continue;
      } 

      //part.seek(PVector.add(part.pos, new PVector(0, height)));
      part.seek(new PVector(mouseX, mouseY));
      part.setColor(color( ( (hue(part.c)+0.5) % 360), saturation(part.c), map(part.pos.y, 0, height, 120, 40)));
      part.update();
      for (int id : ledSystem.isInside(part.pos, part.size/2)) {
        //ledSystem.getLed(id).show(part.c);
        //ledSystem.getLed(id).setColor(part.c);
        ledSystem.getLed(id).setSignalColor();
      }
    }
  }
  **/
}
