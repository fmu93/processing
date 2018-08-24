class TwistSystem {

  ArrayList<Twist> followers;
  Twist lead;

  TwistSystem() {
    followers = new ArrayList<Twist>();
    lead = new Twist(new PVector(width/2, height/2), 0, 80); // TODO constructor needs (PVector pos, float angle)
  }

  void run(PVector force, float torque, float changeR) {
    followers.add(new Twist(lead.pos.copy(), lead.angle, lead.R));
    lead.R += changeR;
    lead.applyForce(force);
    lead.applyTorque(torque*0.02);
    lead.update();
    lead.walls();
    lead.display();

    // to dislay in intervals make a frame counter
    for (int i=followers.size() - 1; i >= 0; i--) {
      Twist twist = followers.get(i);
      // what if we update?
      //twist.update();
      twist.fade();
      // display only at interval?
      twist.display();

      if (twist.isDead()) {
        followers.remove(i);
      }
    }
  }
}
