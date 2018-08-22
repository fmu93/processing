color back = color(0);

Ship ship;
//ArrayList<Body> planets = new ArrayList<Body>();
Body[] planets = new Body[2];
Planet planetA;
Planet planetB;

float gravityCoeff = 0.04;
float thrustCoeff = 0.05;


void setup() {
 size(1800, 1000);
 background(back);
  
 ship = new Ship(width*0.2, height*0.2); 
 ship.size = 20;
 ship.vel = new PVector(2, 0);
 
 planetA = new Planet(width*0.2, height*0.5);
 planetA.mass = 400;
 planetA.size = planetA.mass*0.1;
 
 planetB = new Planet(width*0.8, height*0.8);
 planetB.mass = 600;
 planetB.size = planetB.mass*0.1;;
 
 planets[0] = planetA;
 planets[1] = planetB;
}

void draw() {
  //background(back);
  
  // gravity force on ship
  for(int i = 0; i < planets.length; i++) {
    Body p = planets[i];
    PVector g = PVector.sub(ship.loc, p.loc);
    if (g.mag() > p.size/2) {
      g = g.mult(-gravityCoeff * ship.mass * p.mass / g.magSq());
      ship.applyForce(g);
      p.applyForce(g);
    }
  }
  
  // thurst when clicked
  if (mousePressed) {
     PVector thurst = ship.vel.copy();
     thurst.setMag(thrustCoeff);
     ship.applyForce(thurst);
  }
  
  ship.update();
  ship.display();
  
  //planetA.update();
  planetA.display();
  
  //planetB.update();
  planetB.display();
  
  
  
  
}
