color col;
int step = 20;
int glitchMode = 1;
PVector mid;
float alpha = 0.1;
PVector r = new PVector(0, 0);
PVector mouse = new PVector(0, 0);

void setup() {
  size(1400, 800);
  background(0);
  colorMode(HSB, 360, 100, 100);

  noStroke();

  for (int x = 0; x < width; x += step) {
    for (int y = 0; y < height; y += step) {
      col = color(map(x, 0, width, 0, 360), map(y, 0, height, 100, 30), 100);

      fill(col);
      rect(x, y, step, step);
    }
  }
  mid = new PVector(width/2, height/2);
 // noLoop();
}

void draw() {
  if (frameCount % 10 == 0) {
    loadPixels();

    if (glitchMode == 0) {
      int rand1 = floor(random(40));
      int rand2 = floor(random(20));
      for (int x = 0; x < width - rand1; x++) {
        for (int y = step; y < height - rand2; y++) {
          pixels[x + y*width] = pixels[x + rand1 + (y-rand2) * width];
        }
      }
    } else if (glitchMode == 1) {
      alpha = abs(mouseX - width/2) / 100;

      float rMag = r.mag();

        for (int x = 0; x < width; x++) {
          for (int y = 0; y < height; y++) {
            PVector p0 = new PVector(x, y);
            PVector rel = PVector.sub(p0, mid);
            rel.rotate(alpha);

            if (rel.mag() < rMag) {
              int x0 = floor(mid.x + rel.x);
              int y0 = floor(mid.y + rel.y);
              if (0 < x0 && x0 < width && 0 < y0 && y0 < height) {
                pixels[x + y * width] = pixels[x0 + y0 * width];
              }
            }
        }
      }
    } else {
    }

    updatePixels();
  }
}

void mousePressed() {
  //glitchMode = (glitchMode + 1) % 2;
  
  mouse = new PVector(mouseX, mouseY);
  r = PVector.sub(mouse, mid);

  loadPixels();
  //loop();
}

void mouseReleased() {
  mid = new PVector(mouseX, mouseY);
  //noLoop();
}
