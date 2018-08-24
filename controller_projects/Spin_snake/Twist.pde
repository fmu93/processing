class Twist extends Body {

  float R;
  float lifeSpan;
  float relativeAngle;
  PVector path;
  color c;
  float frictionCoeff = 0.985;
  float angleFrictionCoeff = 0.985;
  boolean dirFollow = false;

  Twist(PVector initialPos, float initialAngle, float newR) {
    super();
    pos = initialPos;
    angle = initialAngle;
    R = newR;
    lifeSpan = 400;
    relativeAngle = 0;
    path = new PVector(1, 0);
    c = color(160, 80, 230, lifeSpan);
  }

  void update() {
    PVector prev = pos.copy();
    //angle -= path.heading(); 
    super.update();
    friction();
    limitSpeed();
    path = PVector.sub(pos, prev);
    R = constrain(R, 1, 200);
  }

  void friction() {
    vel.mult(frictionCoeff);
    aVel *= angleFrictionCoeff;
  }

  void limitSpeed() {
    vel.limit(20); 
    aVel = constrain(aVel, -0.15, 0.15);
  }

  void display() {
    stroke(c);
    strokeWeight(10);
    float angleFollow = angle;
    if (dirFollow) {
      angleFollow -= path.heading();
    }
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angleFollow);
    line(0, -R, 0, R);
    popMatrix();
  }

  void fade() {
    lifeSpan --;
    c = color(160, 80, 230, lifeSpan/2);
  }

  void walls() {
    if (pos.x > width) pos.x = 0;
    if (pos.x < 0) pos.x = width;
    if (pos.y > height) pos.y = 0;
    if (pos.y < 0) pos.y = height;
  }

  boolean isDead() {
    return lifeSpan <= 0;
  }
}
