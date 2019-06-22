ArrayList<Particle> satellites = new ArrayList<Particle>();
ArrayList<Particle> planets = new ArrayList<Particle>();

void setup() {
  size(1000, 1000);
  background(0);
}

void draw() {
  //background(0);

  if (frameCount % 20 == 0) {
    satellites.add(new Particle(new PVector(random(width), random(height)), PVector.random2D())); 
    //planets.add(new Particle());
  }


  for (int i = planets.size()-1; i >= 0; i--) {
    for (int j = satellites.size()-1; j >= 0; j--) {
      PVector r = PVector.sub(satellites.get(j).pos, planets.get(i).pos);
      if (r.magSq() > 2000) {
        satellites.get(j).applyForce(gravityVector(planets.get(i), satellites.get(j), r));
      } else {
        r.setMag(50/r.magSq());
        satellites.get(j).applyForce(r);
      }
    }
  }

  for (int i = satellites.size()-1; i >=0; i--) {
    if (satellites.get(i).die()) {
      satellites.remove(i);
    }
    satellites.get(i).update();
    satellites.get(i).show2();
  }

  for (int i = planets.size()-1; i >=0; i--) {
    //planets.get(i).show();
  }
}

void mousePressed() {
  planets.add(new Particle(new PVector(mouseX, mouseY)));
  if (mouseButton == RIGHT) {
    planets.get(planets.size()-1).attractFactor = -1;
  }
}

float gravity(float otherMass, float thisMass, PVector r) {
  float G = 50;
  float force = -(G*otherMass*thisMass)/r.magSq();
  return force;
}

PVector gravityVector(Particle other_, Particle this_, PVector r) {
  PVector force = r.copy();
  force.normalize();
  force.mult(gravity(other_.mass, this_.mass, r)*other_.attractFactor);
  return force;
}
