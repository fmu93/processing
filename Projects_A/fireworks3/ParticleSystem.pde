class ParticleSystem{
  ArrayList<Particle> particles;
  
  int n = 50;
  PVector gravity = new PVector(0, 0.02);
  
  ParticleSystem() {
    particles = new ArrayList<Particle>();
    for(int i = 0; i < n; i++) {
      particles.add(new Particle());
    }
  }
  
  void run() {
   for (int i=particles.size() - 1; i >= 0; i--) {
    Particle p = particles.get(i);
    
    p.applyForce(gravity.mult(p.mass));
    p.update();
    p.display();
    
    if (p.isDead()) {
     particles.remove(i);
    }
   }  
  }
  
  boolean isDead() {
   if (particles.size() == 0) {
    return true; 
   } else {
     return false;
   }
  }
  
  
  
}
