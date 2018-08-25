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

float forceTol = 0.2;
float torqueTol = 0.3;
float sizeTol = 0.3;

float incNoise = 0.04;
float xNoise = 10;
float yNoise = 2;
float tNoise = 7;
float sNoise = 0;

float wallRepelForce = 0.005;

boolean backOn = true;
boolean automatic = true;

void setup() {
  size(1800, 1000, P2D);
  frameRate(60);
  //fullScreen(P2D);
  background(0);

  // get controller stuff
  control = ControlIO.getInstance(this);
  cont = control.getMatchedDevice("snaker");

  if (cont == null) {
    println("no controller found!");
    System.exit(-1);
  }

  twistSystem = new TwistSystem();
}

void draw() {
  blendMode(ADD);
  if (backOn) background(0);
  getUserInput();

  // automatic perlin noise forces (TODO only after no input)
  if (automatic) {
    // random force
    force.add(map(noise(xNoise), 0, 1, -0.4, 0.4), map(noise(yNoise), 0, 1, -0.4, 0.4));
    xNoise += incNoise;
    yNoise += incNoise;
    
    // repelling force from walls
    float wallForceX = 0;
    float xPos = twistSystem.lead.pos.x;
    if (xPos < width*0.1) wallForceX = (float) Math.pow(wallRepelForce*(width*0.1 - xPos), 2);
    else if (xPos > width*0.9) wallForceX = (float) -Math.pow(wallRepelForce*(xPos - width*0.9), 2);
    
    float wallForceY = 0;
    float yPos = twistSystem.lead.pos.y;
    if (yPos < height*0.1) wallForceY = (float) Math.pow(wallRepelForce*(height*0.1 - yPos), 2);
    else if (yPos > height*0.9) wallForceY = (float) -Math.pow(wallRepelForce*(yPos - height*0.9), 2);
    
    force.add(new PVector(wallForceX, wallForceY));

    // random torque
    torque += map(noise(tNoise), 0, 1, -0.5, 0.5);
    tNoise += incNoise;

    //twistSystem.lead.R = map(noise(sNoise), 0, 1, 15, 200); // tweak Radius itselt
    sizeDot += map(noise(sNoise), 0, 1, -0.3, 0.3); // tweak rate of change of Radius
    sNoise += incNoise*0.1;
    if (abs(sizeDot) < sizeTol) sizeDot = 0;
  }

  // run system
  twistSystem.run(force, torque, sizeDot);
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
