// vintage lines

// param
static final int NUM_LINES = 10;
static final int TRACE = 200;
static final float LINE_DIST = 0.5;
float t = 1;
float inc = 0.05;
static int Z; // zoom factor
int case1 = 0;
int case2 = 0;

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
  //point(x1(t), y1(t));
  //point(x2(t), y2(t));
  
  // case
  case1 = int(float(mouseX)/width * 10);
  print(case1);
  case2 = int(float(mouseY)/height * 10);
  // lines
  for (float i = 0; i < NUM_LINES*LINE_DIST; i += LINE_DIST) {
    
     
    
    line(x1(t+i, case1), y1(t+i, case1), x2(t+i), y2(t+i));
  }
  
  // trace
  strokeWeight(2);
  for (float i = 0; i < TRACE; i++) {
    stroke(200, 200, 100); // Yellow for curve 1
    point(x1(t+i, case1), y1(t+i, case1));
    stroke(100, 220, 100); // green for curve 2
    point(x2(t+i), y2(t+i));
  }
  
  //inc = 0.5 * (mouseX - width/2)/width;
  t += inc;
}

// curve swuitch



// coordinates

float x1(float t, int caseNow) {
  float v = 0;
  switch(caseNow) {
    case 0:
      v = Z*sin(-t/4);
    case 1: 
      v = Z*sin(+t/4);
    case 2:
      v = Z*cos(-t/4);
    case 3: 
      v = Z*cos(+t/4);
  }
  return v;
}

float y1(float t, int caseNow) {
  float v = 0;
  switch(caseNow) {
    case 0:
      v = -Z*cos(-t/2)+Z/4*cos(t/2);
    case 1: 
      v = -Z/2*cos(-t/2)-Z/4*cos(t/2);
    case 2:
      v = -Z/2*cos(-t/2)-Z/2*cos(-t);
    case 3: 
      v = Z/2*cos(-t/2)-Z*cos(-t/2);
  }
  return v;
}

float x2(float t) {
  return -Z/2*sin(t/8);
}

float y2(float t) {
 return  Z*sin(t/8);
}
