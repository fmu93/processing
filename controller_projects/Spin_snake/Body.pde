

class Body {

  PVector pos;
  PVector vel;
  PVector acc;

  float angle;
  float aVel;
  float aAcc;

  float mass;
  float size;

  Body() {
    pos = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);

    angle = 0;
    aVel = 0;
    aAcc = 0;

    mass = 1;
    size = 20;
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acc.add(f);
  }
  void applyTorque(float torque) {
    aAcc += torque;
  }

  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);

    aVel += aAcc;
    angle += aVel;
    aAcc = 0;
  }

  void display() {
    stroke(0);
    fill(255);
    ellipse(pos.x, pos.y, size, size);
  }
}
