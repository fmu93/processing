class Particle {

  PVector pos;
  PVector prevPos = null;
  PVector vel;
  PVector acc;
  float size = 5;
  float mass = 1;
  float lifespan = 800;
  float attractFactor = 1;

  Particle(PVector pos_, PVector vel_) {
    pos = pos_;
    vel = vel_;
    acc = new PVector(0, 0);
  }

  Particle(PVector pos_) {
    this(pos_, new PVector(0, 0));
  }

  Particle() {
    this(new PVector(random(width), random(height)));
  }

  void applyForce(PVector force) {
    force.div(mass);
    acc.add(force);
  }

  void update() {
    prevPos = pos.copy();
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }

  boolean die() {
    lifespan--;
    return lifespan < 0;
  }

  void show2() {
    if (prevPos != null) {
      if (lifespan > 700) {
        stroke(255, map(lifespan, 800, 700, 0, 50));
      } else if (lifespan > 200) {
        stroke(255, 50);
      } else {
        stroke(255, map(lifespan, 200, 0, 50, 0));
      }
      strokeWeight(1);
      line(pos.x, pos.y, prevPos.x, prevPos.y);
    }
  }

  void show() {
    noStroke();
    fill(255);
    ellipse(pos.x, pos.y, size, size);
  }
}
