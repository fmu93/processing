class TwistSystem {

  ArrayList<Twist> followers;
  Twist lead;
  int i = 0;
  boolean colorTransitionOn = true;
  //int interval = 1; //  frames between followers

  TwistSystem() {
    followers = new ArrayList<Twist>();
    lead = new Twist(new PVector(width/2, height/2), HALF_PI, 100); // constructor needs (PVector pos, float angle, float radius)
  }

  void run(PVector force, float torque, float changeR) {
    //if (i%interval == 0) {
      followers.add(new Twist(lead.pos.copy(), lead.angle, lead.R));
    //}
    lead.R += changeR;
    lead.applyForce(force);
    lead.applyTorque(torque*0.01);
    lead.update();
    //lead.walls();
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
}
