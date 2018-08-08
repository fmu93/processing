Mover[] movers;
float gravityCoeff = 0.2;
float frictionCoeff = 0.05;
float windCoeff = 0.5;


void setup() {
  size(500, 500);
  background(255);
  movers = new Mover[5];
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover();
  }
}

void draw() {
  background(255);
  PVector gravity = new PVector(0, gravityCoeff);
  
  for (Mover m : movers) {
    // gravity force
      m.applyGravity(gravity);
    
    // wind when clicked
    if (mousePressed) {
     PVector mouse = new PVector(mouseX, mouseY);
     PVector wind = PVector.sub(mouse, m.loc);
     wind.setMag(windCoeff);
     m.applyForce(wind);
    }
    
    // friction
    PVector friction = m.vel.copy();
    friction.normalize();
    float c = -frictionCoeff;
    friction.mult(c);
    m.applyForce(friction);
    
    m.update();
    m.bounceEdges();
    m.display();
  }
  
}
