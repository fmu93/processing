Body rocket;
Body earth;
PolarBody polarRocket;

float h;


void setup() {
  size(1000, 600, P2D);
  translate(width/2, height/2);

  rocket = new Body (new PVector(0, -200));
  rocket.vel = new PVector(5, 0);

  //polarRocket = new PolarBody(200, 0, 0, -0.1);

  earth = new Body(new PVector(0, 0));
  earth.mass = 100;
  earth.size = 100;

}

void draw() {

  translate(width/2, height/2);
  background(0);

  PVector r = PVector.sub(rocket.pos, earth.pos);
  
  //float r = sqrt(rocket.pos.x*rocket.pos.x + rocket.pos.y*rocket.pos.y);
  //float theta = rocket.pos.y/abs(rocket.pos.y)*acos(rocket.pos.x/r);
  
  //polarRocket.applyPolarForce(gravity(earth.mass, polarRocket.mass, r), 0);
  //polarRocket.update();
  //polarRocket.display();

  rocket.applyForce(gravityVector(earth.mass, rocket.mass, r));
  if (mousePressed) {
    PVector thrust = rocket.vel.copy();
    thrust.setMag(0.1);
    rocket.applyForce(thrust);
  }
  rocket.update();
  rocket.display();

  earth.display();
}

float gravity(float otherMass, float thisMass, PVector r) {
  float G = 100;
  float force = -(G*otherMass*thisMass)/r.magSq();
  return force;
}

PVector gravityVector(float otherMass, float thisMass, PVector r) {
  PVector force = r.copy();
  force.normalize();
  force.mult(gravity(otherMass, thisMass, r));
  return force;
}
