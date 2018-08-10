import java.util.Random;

Random gen = new Random();


class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  
  color c;
  int spikes;
  float mass = 1;
  float size;
  float explosion = 2;
  float lifeSpan;
  
  Particle() {
    pos = new PVector(mouseX, mouseY);
    vel = new PVector(0, 0);
    acc = new PVector(((float) gen.nextGaussian()*0.5), ((float) gen.nextGaussian()*0.5));
    acc.mult(explosion);
    
    c = color(255, 100 + 150*random(1), 150 + random(20, 100));
    spikes = (int) random(4, 8);
    lifeSpan = (float) gen.nextGaussian()*20 + 255;
    size = lifeSpan*0.2;
  }
  
  boolean isDead() {
    if (lifeSpan <= 0) {
      return true;
    } else {
      return false;
    }
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acc.add(f);
  }
  
  void update() {
    fade();
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
    lifeSpan -= 2;
  }
  
  void fade() {
    size = lifeSpan*0.2;
  }
  
  void display() {
    noStroke();
    fill(c);
    star(pos.x, pos.y, size, size/3, spikes);
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
