Mover[] movers;
float gravityCoeff = 0.2;
float frictionCoeff = 0.05;
float windCoeff = 0.3;
float dragCoeff = 0.005;


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
  PVector mouse = new PVector(mouseX, mouseY);
  
  for (Mover m : movers) {
    // down gravity force
    PVector g = PVector.mult(gravity,m.mass);
    m.applyForce(g);
    
    // wind when clicked
    if (mousePressed) {
     PVector wind = PVector.sub(mouse, m.loc);
     wind.setMag(windCoeff);
     m.applyForce(wind);
    }
    
    // drag
    PVector drag = m.vel.copy();
    drag.normalize();
    drag.mult(-1 * dragCoeff * m.vel.magSq() * m.mass);
    m.applyForce(drag);
    
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
