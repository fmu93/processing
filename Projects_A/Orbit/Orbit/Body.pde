import java.util.Random;

Random generator;

class Body {
  
  PVector loc;
  PVector vel;
  PVector acc;
  
  float angle;
  float aVel;
  float aAcc;
  
  
  float mass;
  float size;
  
  Body(float x0, float y0) {
    loc = new PVector(x0, y0);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    mass = 1;
    size = mass;
  }
  
  void update() {
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
    
    aVel += aAcc;
    angle += aVel;
    aAcc = 0;
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acc.add(f);
  }
  
  void bounceEdges() {
    if (loc.x > width - size/2) {
      vel.x = vel.x * -1;
      loc.x = width - size/2;
    } else if (loc.x < size/2) {
      vel.x = vel.x * -1;
      loc.x = size/2;
    } else if (loc.y > height - size/2) {
      vel.y = vel.y * -1;
      loc.y = height - size/2;
      //loc.y = d/2;
    }  else if (loc.y < size/2) {
      vel.y = vel.y * -1;
      loc.y = size/2;
      //loc.y = height - d/2;
    }
  }
  
  void display() {
    stroke(0, 180);
    fill(150, 180);
    ellipse(loc.x, loc.y, size, size);
  }
  
  
}
