class Led {
  PVector pos;
  float size;
  int id;
  color off = color(255, 0, 20, 30);
  color on = color(10, 100, 100);
  color sel = color(20, 100, 100);
  color c = color(0, 0, 0, 0);
  float lastSignal = 0;
  boolean isSignal = false;
  boolean isSelected = false;
  boolean debug = true;

  Led(PVector pos_, int _id) {
    pos = pos_;
    size = ledSize;
    id = _id;
  }

  //Led(long x, long y) {
  //  this(new PVector(x, y));
  //}


  void move(PVector newPos) {
    this.pos = newPos;
  }

  void show(color _fill) {
    //strokeWeight(1);
    //stroke(0);
    noStroke();
    fill(_fill);
    pushMatrix();
    translate(pos.x, pos.y);
    //rectMode(CENTER);
    ellipse(0, 0, size, size);
    if (debug) {
      fill(0);
      text(id, 0, 0); // does an led know its id?
    }
    popMatrix();
  }

  void show() {
    //color fill;
    //if (isSignal) fill = on;
    //else if (isSelected) fill = sel;
    //else fill = off;
    if (isSelected) setSignalColor();

    show(c);
  }

  void setColor(color _c) {
    c = _c;
  }

  void setSignalColor() {
    c = color((hue(c)+0.5) % 1.0, saturation(c)-signalSaturation, brightness);
  }
  
  String getHSB() {
    return hue(c) + "," + saturation(c) + "," + brightness(c);
  }
  
  String getRGB() {
    return red(c) + "," + green(c) + "," + blue(c);
  }

  void signal() {
    isSignal = true;
    lastSignal = millis();
  }

  void fadeSignal() {

    if (millis() - lastSignal >= signalDelay) lastSignal = millis();
    float fadeFactor = ( millis() - lastSignal < (signalDelay/2) )? ( map(millis()-lastSignal, 0, signalDelay/2*fadeDelay, 0, signalSaturation) ) : ( map(millis()-lastSignal, signalDelay/2 * (1 + fadeDelay) , signalDelay, signalSaturation, 0) );
    //float fadeFactor = map(millis()-lastSignal, 0, curveFactor, 0, 100);

    c = color((hue(c)) % 1.0, saturation(c)-fadeFactor, brightness);
  }

  void switchSelect() {
    isSelected = !isSelected;
  }

  void select() {
    isSelected = true;
  }

  void unSelect() {
    isSelected = false;
  }
}
