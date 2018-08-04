// vintage lines

// param
static final int NUM_LINES = 12;
static final int TRACE = 200;
float t = 1;
float inc;

void setup() {
  background(20);
  size(800, 800);
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
  for (int i = 0; i < NUM_LINES; i++) {
    line(x1(t+i), y1(t+i), x2(t+i), y2(t+i));
  }
  
  // trace
  strokeWeight(2);
  stroke(180);
  for (int i = 0; i < TRACE; i++) {
    point(x1(t+i), y1(t+i));
    point(x2(t+i), y2(t+i));
  }
  
  inc = 0.5 * (mouseX - width/2)/width;
  t += inc;
}

// coordinates

float x1(float t) {
  return 200*sin(-t/4) - 100*cos(t/5);
}

float y1(float t) {
 return  -4*sin(-t/2) - width/4*cos(-t/8)*sin(t/2);
}

float x2(float t) {
  return -300*sin(t/6) + cos(-t/4);
}

float y2(float t) {
 return  width/5*sin(t/4) - width/8*sin(-t/2);
}
