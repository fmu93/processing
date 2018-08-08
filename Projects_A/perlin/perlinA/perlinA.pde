// test perlin noise
import java.util.Random;

float t = 0;
int ySpeed = 2;
Random gen;

void setup() {
  size(1000, 400);
  background(210);
  gen = new Random();
}

void draw() {
  // pixel stuff
  loadPixels();
  for (int i = 0; i < height; i++) {
    for (int j = 0; j < width - ySpeed - 1; j++) {
      pixels[i*width + j] = pixels[i*width + j + ySpeed];
    }
  }

updatePixels();

  
  // new perlin pos
  float n1 = noise(t*0.02);
  float y = map(n1, 0, 1, 0, height);
  float s = map(n1, 0, 1, 10, 60);
  float c = map(n1, 0, 1, 120, 60);
  float h  = (float) gen.nextGaussian();
  h = h * 2;
  h = h + mouseY*0.15;
  
  noStroke();
  fill(s, h);
  ellipse(width*0.9, y, h, h);
  
  t++;
}
