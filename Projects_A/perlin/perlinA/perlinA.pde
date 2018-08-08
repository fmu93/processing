// test perlin noise
import java.util.Random;

float t = 0;
int ySpeed = 2;
Random gen;

void setup() {
  size(1000, 400);
  background(240);
  gen = new Random();
}

void draw() {
  // pixel stuff
  loadPixels();
  for (int i = 0; i < height; i++) {
    for (int j = 0; j < width - ySpeed; j++) {
      pixels[i*width + j] = pixels[i*width + j + ySpeed];
    }
  }

updatePixels();

  
  // new perlin pos
  float n1 = noise(t*0.02);
  float y = map(n1, 0, 1, 0, height);
  float s = map(n1, 0, 1, 1, 8);
  float c = map(n1, 0, 1, 0, 180);
  float h  = (float) gen.nextGaussian();
  h = h * 10;
  h = h + 50;
  println(h);
  
  noStroke();
  fill(h);
  ellipse(width*0.8, y, r * s, r * s);
  
  t++;
}
