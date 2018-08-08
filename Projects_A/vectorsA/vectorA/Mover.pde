import java.util.Random;

Random generator;

class Mover {
  
  PVector loc;
  PVector vel;
  PVector acc;
  float mass;
  
  Mover() {
    loc = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    //mass = ((float) generator.nextGaussian() + 10); // normally -5 to +5
    mass = 1 + random(10);
  }
  
  void update() {
    vel.add(acc);
    vel.limit(5);
    loc.add(vel);
    acc.mult(0);
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acc.add(f);
  }
  
  void bounceEdges() {
    if (loc.x > width || loc.x < 0) {
      vel.x = vel.x * -1;
    }
    if (loc.y > height || loc.y < 0) {
      vel.y = vel.y * -1;
    }
  }
  
  void display() {
    stroke(0);
    strokeWeight(2);
    fill(80);
    ellipse(loc.x, loc.y, 20, 20);
  }
  
  
}
