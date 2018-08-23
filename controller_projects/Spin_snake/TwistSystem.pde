class TwistSystem {

  ArrayList<Twist> twists;

  TwistSystem() {
    twists = new ArrayList<Twist>();
    twists.add(new Twist());
  }

  void makeTwist() {
    twists.add(new Twist());
  }

  void run(PVector force, float torque) {
    for (int i=twists.size() - 1; i >= 0; i--) {
      Twist twist = twists.get(i);

      twist.applyForce(force);
      twist.applyTorque(torque*0.02);

      twist.update();
      twist.walls();
      twist.display();

      if (twist.isDead()) {
        twists.remove(i);
      }
    }
  }
}
