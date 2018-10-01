class Body {

  PVector pos;
  PVector vel;
  PVector acc;

  float angle;
  float aVel;
  float aAcc;

  float mass;
  float size;
  Flash flash;

  Body() {
    pos = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);

    angle = 0;
    aVel = 0;
    aAcc = 0;

    mass = 1;
    size = 120;
    
    flash = new Flash();
  }
  
  void run(PVector force) {
  applyForce(force);
  wallsTeleport();
  update();
  display();
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
    vel.limit(3);
    pos.add(vel);
    acc.mult(0);

    aVel += aAcc;
    angle += aVel;
    aAcc = 0;
  }

  void wallsTeleport() {
    if (pos.x > width) pos.x = 0;
    else if (pos.x < 0) pos.x = width;
    if (pos.y > height) pos.y = 0;
    else if (pos.y < 0) pos.y = height;
  }

  void display() {
    //stroke(0);
    fill(flash.getColor());
    ellipse(pos.x, pos.y, size, size);
  }
}
