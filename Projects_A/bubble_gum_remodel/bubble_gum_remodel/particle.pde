 import java.util.Random;
 
 class Particle {
   
   color c;
   PVector pos;
   PVector vel;
   PVector acc;
   float mass;
   int size; // what shape?
   float friction = 0.97; 
   float s = 0.05; // strength of pull
   float w = 0.1; // wobblyness
   float RInfluence = height/4; // radius of influence of force
   Random generator = new Random();

  Particle() {
   c = color(random(100, 255), random(100, 255), random(100, 255));
   pos = new PVector(random(width), random(height));
   vel = new PVector(0,0);
   acc = new PVector(0,0);
   size = (int) (generator.nextGaussian() * 5) + 20;
   mass = pow(size, 2);
  }
  
  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acc.add(f);
  }
  
  void checkCollisionOther(Particle other) {
   PVector distV = PVector.sub(other.pos, pos);
   if (distV.mag() < (other.size + size)/2) {
     PVector repel = distV.normalize().mult(w);
     vel.sub(repel);
     other.vel.add(repel);
   }
  }
  
  void wobble() {
   acc.add((float) generator.nextGaussian() * random(w), (float) generator.nextGaussian() * random(w));
  }
  
  void pointer() {
    PVector mouse = new PVector(mouseX, mouseY);
    PVector diff = PVector.sub(pos, mouse);
    if (RInfluence/diff.mag() >= 1) {
      //speed.add(diff.normalize().mult(s*(1/pow(diff.mag(), 1)))); 
      vel.add(diff.normalize().mult( s * pow(1 - diff.mag()/RInfluence, 0.5) )); 
    }
    pos.add(vel);
    vel.mult(friction);    
  }
  
 
  void walls() {
    if (pos.x > width) {
     pos.x = 0; 
    } else if (pos.x < 0) {
      pos.x = width;
    }
    if (pos.y > height) {
      pos.y = 0;
    } else if (pos.y < 0) {
      pos.y = height;
    }
  }
  
  void display() {
    stroke(c);
    fill(c);
    ellipse(pos.x, pos.y, size, size);
  }
   
 }
