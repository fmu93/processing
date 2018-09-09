import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

ControlDevice cont;
ControlIO control;

Twist twist;
ArrayList<TwistSystem> twistSystems = new ArrayList<TwistSystem>();
int n = 2;

PVector force = new PVector(0, 0);
float torque = 0;
float sizeDot = 0;
float smaller;
float bigger;
float aBtn;

float forceTol = 0.2;
float torqueTol = 0.3;
float sizeTol = 0.3;

boolean backOn = true;
boolean automatic = true;
boolean controllerOn = false;

void setup() {
  size(1800, 1000, P2D);
  frameRate(60);
  //fullScreen(P2D);
  background(0);

  if (controllerOn) {
    // get controller stuff
    control = ControlIO.getInstance(this);
    cont = control.getMatchedDevice("snaker");

    if (cont == null) {
      println("no controller found!");
      System.exit(-1);
    }
  }  
  for (int i = 0; i < n; i++) {
    twistSystems.add(new TwistSystem());
  }
}

void draw() {
  blendMode(ADD);
  if (backOn) background(0);
  if (controllerOn) getUserInput();

  // automatic perlin noise forces (TODO only after no input)
  for (TwistSystem twistSystem : twistSystems) {
    if (automatic) {
      twistSystem.randomForce();
    }

    // run system
    twistSystem.run(force, torque, sizeDot);
    twistSystem.wallsRepel();
  }
}

public void getUserInput() {
  // force in x and Y
  float xForce = cont.getSlider("xAxis").getValue();
  float yForce = cont.getSlider("yAxis").getValue();
  force = new PVector(xForce, yForce);
  if (force.mag() < forceTol) force.mult(0);

  // torque
  torque = cont.getSlider("xRot").getValue();
  if (abs(torque) < torqueTol) torque = 0;
  else if (torque > torqueTol) torque -= torqueTol;
  else if (torque < -torqueTol) torque += torqueTol;

  // size
  sizeDot = map(cont.getSlider("yRot").getValue(), -1, 1, 1, -1);
  if (abs(sizeDot) < sizeTol) sizeDot = 0;
  else if (sizeDot > sizeTol) sizeDot -= sizeTol;
  else if (sizeDot < -sizeTol) sizeDot += sizeTol;

  //smaller = map(cont.getButton("smaller").getValue(), 0, 8, 0, 1);
  //bigger = map(cont.getButton("bigger").getValue(), 0, 8, 0, 1);
  //aBtn = map(cont.getButton("aBtn").getValue(), 0, 8, 0, 1);
  //if (aBtn == 1) backOn = !backOn;
}
