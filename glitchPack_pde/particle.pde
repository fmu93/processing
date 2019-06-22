class Particle {

  PVector pos;
  PVector prevPos = null;
  PVector vel;
  PVector acc;
  float size = 20;
  float mass = 1;
  float lifespan = 800;
  float attractFactor = 1;
  float maxSpeed = 10;
  float maxForce = 0.1;
  color c = color(100,100,100);

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
  
  void setColor(color _c) {
    c = _c;
  }

  void applyForce(PVector force) {
    force.div(mass);
    acc.add(force);
  }

  void seek(PVector target) {
    PVector desired = PVector.sub(target, pos); // A vector pointing from the position to the target

    // If the magnitude of desired equals 0, skip out of here
    // (We could optimize this to check if x and y are 0 to avoid mag() square root
    if (desired.mag() == 0) return;

    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxSpeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, vel);
    steer.limit(maxForce); // Limit to maximum steering force

    this.applyForce(steer);
  }

  void friction() {
    vel.mult(0.98);
  }

  void update() {
    prevPos = pos.copy();
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);

    friction();
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
    fill(255, 150);
    ellipse(pos.x, pos.y, size, size);
  }
}
