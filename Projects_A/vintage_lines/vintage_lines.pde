// vintage lines

// param
static final int NUM_LINES = 12;
static final int TRACE = 60;
static final float LINE_DIST = 0.4;
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
  case1 = int(float(mouseX)/width * 4);
  case2 = int(float(mouseY)/height * 4);
  // lines
  for (float i = 0; i < NUM_LINES*LINE_DIST; i += LINE_DIST) {
    
     
    
    line(x1(t+i, case1), y1(t+i, case1), x2(t+i, case2), y2(t+i, case2));
  }
  
  // trace
  strokeWeight(2);
  for (float i = 0; i < TRACE; i++) {
    stroke(200, 200, 100); // Yellow for curve 1
    point(x1(t+i, case1), y1(t+i, case1));
    stroke(100, 220, 100); // green for curve 2
    point(x2(t+i, case2), y2(t+i, case2));
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
      v = Z*sin(-t/4)+Z/2*cos(t/4);
      break;
    case 1: 
      v = Z/2*cos(-t/2)+Z/2*sin(t);
      break;
    case 2:
      v = Z/2*cos(-t/4) + Z*sin(t);
      break;
    case 3: 
      v = Z*cos(+t/4) - Z/4*sin(-t/2);
      break;
  }
  return v;
}

float y1(float t, int caseNow) {
  float v = 0;
  switch(caseNow) {
    case 0:
      v = -Z*cos(-t/2)+Z/4*cos(t/2);
      break;
    case 1: 
      v = -Z/2*sin(-t)-Z*cos(t/2);
      break;
    case 2:
      v = -Z/2*cos(-t/2)-Z/2*sin(-t);
      break;
    case 3: 
      v = Z/2*cos(-t/2)-Z*cos(t/2) + Z*sin(t/2);
      break;
  }
  return v;
}

float x2(float t, int caseNow) {
  float v = 0;
  switch(caseNow) {
    case 0:
      v = Z*cos(t/4 - PI/2);
      break;
    case 1:
      v = -Z/2*sin(t/8);
      break;
    case 2:
      v = Z/8*cos(t/8) + Z/4*cos(-t/6) - Z/5*sin(t/4);
      break;
    case 4:
      v = 0;
      break;
  }
  return v;
}

float y2(float t, int caseNow) {
  float v = 0;
  switch(caseNow) {
   case 0:
     v = 0;
     break;
   case 1: 
      v = Z/1.5*sin(t/8) + Z/2*cos(-t/2);
      break;
    case 2:
      v = Z/2*sin(t/8) + Z/2*cos(-t/2);
      break;
    case 3:
      v = 0;
      break;
  }
 return  v;
}
