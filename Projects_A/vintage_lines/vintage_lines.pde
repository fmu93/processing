// vintage lines

// param
static final int NUM_LINES = 10;
static final int TRACE = 200;
static final float LINE_DIST = 0.5;
float t = 1;
float inc = 0.05;
static int Z; // zoom factor

void setup() {
  background(20);
  size(800, 800);
  Z = width/3;
}

void draw() {
  background(20);
  strokeWeight(3);
  stroke(255);
  translate(width/2, height/2);
  
  // points
  point(x1(t), y1(t));
  point(x2(t), y2(t));
  
  // lines
  for (float i = 0; i < NUM_LINES*LINE_DIST; i += LINE_DIST) {
    line(x1(t+i), y1(t+i), x2(t+i), y2(t+i));
  }
  
  // trace
  strokeWeight(2);
  for (int i = 0; i < TRACE; i++) {
    stroke(200, 200, 100); // Yellow for curve 1
    point(x1(t+i), y1(t+i));
    stroke(100, 220, 100); // green for curve 2
    point(x2(t+i), y2(t+i));
  }
  
  //inc = 0.5 * (mouseX - width/2)/width;
  t += inc;
}

// coordinates

float x1(float t) {
  return Z*sin(-t/4);
}

float y1(float t) {
 return  -Z/2*cos(-t/2)+Z/5*cos(t/2);
}

float x2(float t) {
  return -Z/2*sin(t/8);
}

float y2(float t) {
 return  Z*sin(t/8);
}
