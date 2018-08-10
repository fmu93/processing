class ParticleSystem{
  ArrayList<Particle> particles;
  
  ParticleSystem() {
    particles = new ArrayList<Particle>();
  }
  
  void run() {
   for (int i=particles.size() - 1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.doFade();
    p.move();
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
