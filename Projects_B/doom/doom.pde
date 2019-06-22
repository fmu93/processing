import peasy.*;

PeasyCam cam;
int scl = 80;
ArrayList<ArrayList<Float>> heights = new ArrayList<ArrayList<Float>>();
float speed = 10;
float t = 3;
float toff = 0;
float yNoise = 0.002;
float xNoise = 0.1;
float zCoef = 300;
int maxRows;
float shadow = 3000/scl;



void setup() {
  size(1000, 700, P3D);
  cam = new PeasyCam(this, height);
  maxRows = width*6/scl;
} 

void draw() {
  background(30, 0, 0);
  translate(-scl*maxRows*0.5, -scl*maxRows*0.4, -scl*maxRows*0.8);
  rotateX(HALF_PI/1.6);  
  rotateZ(sin(t/4000)/8);

  float fade;
  for (int j = 0; j < heights.size()-1; j++) {
    if (j <= shadow) {
      fade = map(j, 0, shadow, 0, 350);
    } else {
      fade = 255;
    }

    ArrayList<Float> z0 = heights.get(j);
    ArrayList<Float> z1 = heights.get(j+1);

    for (int i = 0; i < heights.get(0).size()-1; i ++) {
      float x0 = i*scl;
      float y0 = j*scl + toff;
      float z00 = z0.get(i);
      float z01 = z0.get(i+1);
      float z10 = z1.get(i);
      float z11 = z1.get(i+1);

      if (z0.get(i) > 250) {
        fill(130, fade);
        stroke(0, fade);
      } else if (z0.get(i) < -100) {
        fill(0, 0, 130, fade);
        stroke(0, fade);
        
        z00 = - 100;
        z01 = -100;
        z10 = -100;
        z11 = -100;
      } else {
        fill(0, fade); 
        stroke(255, fade);
      }

      beginShape(TRIANGLE_STRIP);
      vertex(x0, y0, z00);
      vertex(x0, y0 + scl, z10);
      vertex(x0 + scl, y0, z01);
      vertex(x0 + scl, y0 + scl, z11);
      endShape();
    }
  }

  t += speed;
  toff += speed;
  if (toff >= scl) {
    generate();
    toff = 0;
  }
}

void generate() {
  ArrayList<Float> newGen = new ArrayList<Float>();
  for (int i = 0; i < maxRows; i++) {
    //newGen.add(((0.4*sin(t/4000) + 1.3)*noise(i*xNoise, t*yNoise) + cos(t/4000 + HALF_PI) + sin(i/100 + 0.4))*scl*5);
    float z = noise(i*xNoise/2, t*yNoise/4)*2 + pow(noise(i*xNoise + 10, t*yNoise), 2) - noise(i*xNoise/3 + 10, t*yNoise/2 + 10)*2;
    z *= zCoef;
    newGen.add(z);
  }

  heights.add(0, newGen);
  if (heights.size() > maxRows)
    heights.remove(heights.size() - 1);
}

void randomRough() {
  xNoise += cos(t/1000);
}
