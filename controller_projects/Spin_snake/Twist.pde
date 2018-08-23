class Twist extends Body {

  float R;
  float lifeSpan;
  float relativeAngle;
  PVector path;
  color c;
  float frictionCoeff = 0.98;
  float angleFrictionCoeff = 0.98;
  boolean dirFollow = false;

  Twist() {
    super();
    R = 80;
    lifeSpan = 150;
    relativeAngle = 0;
    path = new PVector(1, 0);
    c = color(220, 80, 160, 100);
  }

  void update() {
    PVector prev = pos.copy();
    //angle -= path.heading(); 
    super.update();
    friction();
    limitSpeed();
    path = PVector.sub(pos, prev);
    R = constrain(R, 1, 200);
    lifeSpan--;
  }

  void friction() {
    vel.mult(frictionCoeff);
    aVel *= angleFrictionCoeff;
  }

  void limitSpeed() {
    vel.limit(20); 
    aVel = constrain(aVel, -0.1, 0.1);
  }

  void display() {
    stroke(c);
    strokeWeight(10);
    float angleFollow = angle;
    if (dirFollow) {
    angleFollow -= path.heading();
    }
    line(pos.x - R*sin(angleFollow), pos.y - R*cos(angleFollow), pos.x + R*sin(angleFollow), pos.y + R*cos(angleFollow));
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
