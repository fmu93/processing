import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

ControlDevice cont;
ControlIO control;

Twist twist;
TwistSystem twistSystem;
int n = 100;

PVector force;
float torque;
float sizeDot;
float smaller;
float bigger;
float aBtn;

boolean backOn = true;

void setup() {
  size(1800, 1000, P2D);
  background(0);

  // get controller stuff
  control = ControlIO.getInstance(this);
  cont = control.getMatchedDevice("snaker");

  if (cont == null) {
    println("no controller found!");
    System.exit(-1);
  }

  //twist = new Twist();
  twistSystem = new TwistSystem();
}

void draw() {
  blendMode(ADD);
  if (backOn) background(0);
  getUserInput();

  twistSystem.run(force, torque, sizeDot);

  //twist.applyForce(force);
  //twist.applyTorque(torque*0.02);

  //twist.update();
  //twist.walls();
  //twist.display();
}

public void getUserInput() {
  // force in x and Y
  float xForce = cont.getSlider("xAxis").getValue();
  float yForce = cont.getSlider("yAxis").getValue();
  force = new PVector(xForce, yForce);
  if (force.mag() < 0.2) {
    force.mult(0);
  }
  // torque and size
  torque = cont.getSlider("xRot").getValue();
  if (abs(torque) < 0.1) torque = 0;
  sizeDot = map(cont.getSlider("yRot").getValue(), -1, 1, 1, -1);
  if (abs(sizeDot) < 0.5) sizeDot = 0;

  //smaller = map(cont.getButton("smaller").getValue(), 0, 8, 0, 1);
  //bigger = map(cont.getButton("bigger").getValue(), 0, 8, 0, 1);
  aBtn = map(cont.getButton("aBtn").getValue(), 0, 8, 0, 1);
  if (aBtn == 1) backOn = !backOn;
}
