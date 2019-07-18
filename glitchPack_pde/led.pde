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
    fill(hue(_fill), saturation(_fill), 2*brightness(_fill));
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
    c = color((hue(c)+0.3) % 1.0, saturation(c)-signalSaturation, brightness);
  }

  void setMildSignal() {
    c = color((hue(c)+0.5)%1.0, saturation(c)-signalSaturation*0.5, brightness);
  }

  String getHSB() {
    return hue(c) + "," +  saturation(c) + "," + pow(brightness(c), 2.5); // TODO gamma correction here
  }

  String getRGB() {
    return red(c) + "," + green(c) + "," + blue(c);
  }

  void signal() {
    isSignal = true;
    lastSignal = millis();
  }

  float getBrightness() {
    return brightness(c);
  }

  void setBrightness(float b) {
    c = color(hue(c), saturation(c), b);
  }

  void fadeSignal() {

    if (millis() - lastSignal >= signalDelay) lastSignal = millis();

    float fadeFactor = 0; 
    if ( millis() - lastSignal < (signalDelay/2*fadeDelay)) { // TODO only fade out brightness and leave saturation
      fadeFactor = map(millis()-lastSignal, 0, signalDelay/2, 0, 1);
    } else if (millis() - lastSignal >= (signalDelay/2*(1-fadeDelay))) {
      fadeFactor = map(millis()-lastSignal, signalDelay/2, signalDelay, 1, 0);
    }

    c = color((hue(c)+(flowOn?0.5:0)) % 1.0, (flowOn?0.9:1)-fadeFactor*signalSaturation, brightness*fadeFactor*(flowOn?0.8:1));
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
