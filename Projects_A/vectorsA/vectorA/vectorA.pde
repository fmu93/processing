Mover[] movers;

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
  PVector gravity = new PVector(0, 0.2);
  
  for (Mover m : movers) {
    if (mousePressed) {
     PVector mouse = new PVector(mouseX, mouseY);
     PVector wind = PVector.sub(mouse, m.loc);
     wind.setMag(0.2);
     m.applyForce(wind);
    }
    
    m.applyGravity(gravity);
    m.update();
    m.bounceEdges();
    m.display();
  }
  
}
