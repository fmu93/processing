class Particle {
  
 color c;
 PVector pos;
 PVector speed;
 float size;
 int spikes;
 float decay;
 float gravity;
 float fade;
 float lifespan = 255;
  
  Particle(boolean isGlitter, float radius, float[] speedRange, int[] spikeRange, float newDecay, float newGravity, float newFade) {
    
    if (isGlitter) {
      c = color(random(180, 255), random(50,150), random(50, 150));
    }else{
      c = color(random(0, 255), random(0,255), random(0, 255)); 
    }
    
    spikes = int(random(spikeRange[0], spikeRange[1]));
    pos = new PVector(mouseX, mouseY);
    decay = newDecay;
    gravity = newGravity;
    size = radius;
    fade = newFade;
    speed = PVector.random2D();
    speed.mult(random(speedRange[0], speedRange[1]));
  }
  
  void flicker() {
    c = color(random(180, 255), random(50,150), random(50, 150));
  }
  
  boolean isDead() {
   if (lifespan <= 0) {
    return true; 
   } else {
     return false;
   }
  }
  
  void doFade() {
    if (size > 0) {
      size -= fade*0.5;      
    }
  }
  
  void move() {
    speed.sub(0, -gravity);
    if (speed.mag() > 1.0) {
      speed.mult(decay);
    }
    pos.add(speed);
    lifespan -= 1;
  }
  
  void follow() {
    pos = new PVector(mouseX, mouseY);
  }
  
  
  
  void display() {
    noStroke();
    fill(c, lifespan);
    star(pos.x, pos.y, size, size/5, spikes);
  }
  
  void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
  
  
}
