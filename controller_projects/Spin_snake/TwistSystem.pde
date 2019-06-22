class TwistSystem {

  ArrayList<Twist> followers;
  Twist lead;
  int i = 0;
  boolean colorTransitionOn = true;

  float wallRepelForce = 0.005;
  float incNoise;
  float xNoise;
  float yNoise ;
  float tNoise;
  float sNoise;

  TwistSystem() {
    followers = new ArrayList<Twist>();
    lead = new Twist(new PVector(width/2, height/2), HALF_PI, 100); // constructor needs (PVector pos, float angle, float radius)
    incNoise = random(0.02, 0.05);
    xNoise = random(100);
    yNoise = random(100);
    tNoise = random(100);
    sNoise = random(100);
  }

  void run(PVector force, float torque, float changeR) {
    followers.add(new Twist(lead.pos.copy(), lead.angle, lead.R));
    lead.R += changeR;
    lead.applyForce(force);
    lead.applyTorque(torque*0.01);
    lead.update();
    lead.display();

    for (int i=followers.size() - 1; i >= 0; i--) {
      Twist twist = followers.get(i);
      // what if we update?
      if (colorTransitionOn) twist.colorTransition();
      twist.fade();
      twist.display();

      if (twist.isDead()) {
        followers.remove(i);
      }
    }
    i++;
  }

  void wallsRepel() {
    // repelling force from walls
    float wallForceX = 0;
    float xPos = lead.pos.x;
    if (xPos < width*0.1) wallForceX = (float) Math.pow(wallRepelForce*(width*0.1 - xPos), 2);
    else if (xPos > width*0.9) wallForceX = (float) -Math.pow(wallRepelForce*(xPos - width*0.9), 2);

    float wallForceY = 0;
    float yPos = lead.pos.y;
    if (yPos < height*0.1) wallForceY = (float) Math.pow(wallRepelForce*(height*0.1 - yPos), 2);
    else if (yPos > height*0.9) wallForceY = (float) -Math.pow(wallRepelForce*(yPos - height*0.9), 2);

    lead.applyForce(new PVector(wallForceX, wallForceY));
  }

  void randomForce() {
    // random force
    xNoise += incNoise;
    yNoise += incNoise; 
    lead.applyForce(new PVector(map(noise(xNoise), 0, 1, -autoForce, autoForce), map(noise(yNoise), 0, 1, -autoForce, autoForce)));

    // random torque
    tNoise += incNoise;
    lead.applyTorque(map(noise(tNoise), 0, 1, -0.005, 0.005));

    // size
    lead.R = map(noise(sNoise), 0, 1, 15, 200); // tweak Radius itselt
  }
}
