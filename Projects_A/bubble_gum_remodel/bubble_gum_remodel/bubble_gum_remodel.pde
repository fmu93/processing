int n = 420; 
color back = color(0);
ArrayList<Particle> particles = new ArrayList<Particle>();
int pixelate = 8;
boolean pixelateOn = false;
float forceCoeff = 2000;
float frictionCoeff = 1;

void setup() {
  frameRate(60);
  size(1000, 1000);           // set size to that of the image
  colorMode(HSB, 255);               // allows us to access the brightness of a color
  background(back);

  // Start particles
  for (int i = 0; i < n; i++) {
    particles.add(new Particle());
  }
}

void draw() {
  background(back);
  
  PVector mouse = new PVector(mouseX, mouseY);
  
  for (Particle p : particles) {
    // mouse force
     PVector force = PVector.sub(mouse, p.pos);
     force.setMag(forceCoeff/force.magSq());
     p.applyForce(force);
     
    // friction
    PVector friction = p.vel.copy();
    friction.normalize();
    float c = -frictionCoeff;
    friction.mult(c);
    p.applyForce(friction);
    
    
   p.wobble();
   p.update();
   //p.pointer();
   // reaction among particles
   for (Particle p2 : particles) {
     p.checkCollisionOther(p2);
   }
   p.walls();
   p.display(); 
  }
  
  // influence area
  //noFill();
  //stroke(back, 80);
  //ellipse(mouseX, mouseY, height/2, height/2);
  
  // pixelate
  if (pixelateOn) {
    pixelateImage(pixelate);
    //filter(INVERT);
  }
  
  // frame
  strokeWeight(30);
  stroke(back);
  noFill();
  rect(0,0,width,height);
  strokeWeight(1);
  
}

void keyPressed() {
  //pixelateOn = !pixelateOn;
}

void mousePressed() {
  forceCoeff *= -1;
    for (Particle p : particles) {
      p.s = p.s * -1;
    }
}

void pixelateImage(int pxSize) {
 
  // use ratio of height/width...
  float ratio;
  if (width < height) {
    ratio = height/width;
  }
  else {
    ratio = width/height;
  }
  
  // ... to set pixel height
  int pxH = int(pxSize * ratio);
  loadPixels();
  
  noStroke();
  for (int x=0; x<width; x+=pxSize) {
    for (int y=0; y<height; y+=pxH) {
      fill(pixels[x + y*width]);
      rect(x, y, pxSize, pxH);
    }
  }
}

void doubleClicked() {
  background(back);
}

public void mouseClicked(MouseEvent evt) {
  if (evt.getCount() == 2)doubleClicked();
}
