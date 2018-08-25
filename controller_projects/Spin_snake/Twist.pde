class Twist extends Body {

  float R;
  float lifeSpan;
  float relativeAngle;
  PVector path;
  color fill;
  FloatList baseColor;
  float frictionCoeff = 0.985;
  float angleFrictionCoeff = 0.985;
  boolean dirFollow = false;

  Twist(PVector initialPos, float initialAngle, float newR) {
    super();
    pos = initialPos;
    angle = initialAngle;
    R = newR;
    lifeSpan = 500;
    relativeAngle = 0;
    path = new PVector(1, 0);
    baseColor = new FloatList(200, 80, 230);
    fill = color(baseColor.get(0), baseColor.get(1), baseColor.get(2), lifeSpan/2);
  }

  void update() {
    PVector prev = pos.copy();
    //angle -= path.heading(); 
    super.update();
    friction();
    limitSpeed();
    path = PVector.sub(pos, prev);
    R = constrain(R, 15, 200);
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
    pushStyle();
    pushMatrix();
    
    stroke(fill);
    strokeWeight(10);
    float angleFollow = angle;
    if (dirFollow) {
      angleFollow -= path.heading();
    }
    translate(pos.x, pos.y);
    rotate(angleFollow);
    line(0, -R, 0, R);
    
    popStyle();
    popMatrix();
  }
  
  void colorTransition() {
    // Red
    baseColor.sub(0, 0.2);
    // Green
    baseColor.mult(1, 1.012);
    baseColor.sub(1, 1.15);
    // Blue
    baseColor.mult(2, 0.99);
    baseColor.add(1, 0.2);
  }

  void fade() {
    lifeSpan --;
    fill = color(baseColor.get(0), baseColor.get(1), baseColor.get(2), lifeSpan/2);
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
