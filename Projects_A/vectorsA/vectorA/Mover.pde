import java.util.Random;

Random generator;

class Mover {
  
  PVector loc;
  PVector vel;
  PVector acc;
  float mass;
  float d;
  
  Mover() {
    loc = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    //mass = ((float) generator.nextGaussian() + 10); // normally -5 to +5
    mass = random(1, 2);
    d = map(mass, 1, 2, 10, 50);
  }
  
  void update() {
    vel.add(acc);
    vel.limit(5);
    loc.add(vel);
    acc.mult(0);
  }
  
  void applyGravity(PVector gravity) {
    applyForce(PVector.mult(gravity, mass));
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acc.add(f);
  }
  
  void bounceEdges() {
    if (loc.x > width - d/2) {
      vel.x = vel.x * -1;
      loc.x = width - d/2;
    } else if (loc.x < d/2) {
      vel.x = vel.x * -1;
      loc.x = d/2;
    } else if (loc.y > height - d/2) {
      vel.y = vel.y * -1;
      loc.y = height - d/2;
    }  else if (loc.y < d/2) {
      vel.y = vel.y * -1;
      loc.y = d/2;
    }
  }
  
  void display() {
    stroke(0, 120);
    strokeWeight(2);
    fill(80, 120);
    ellipse(loc.x, loc.y, d, d);
  }
  
  
}
