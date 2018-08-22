import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

ControlDevice cont;
ControlIO control;

float xAxis;
float yAxis;
float aBtn;
float bBtn;
color c = color(150, 20, 200);
float prevX;
float prevY;
boolean backOn;

void setup() {
 size(1800, 1000);
 background(0);
 blendMode(ADD);
 
 // get controller stuff
 control = ControlIO.getInstance(this);
 cont = control.getMatchedDevice("stick_A");
 
 if (cont == null) {
  println("no controller found!");
  System.exit(-1);
 }
 
}

void draw() {
  if(backOn)   background(0);
  
  getUserInput();
  
  //
  if(bBtn == 1) {
   prevX = xAxis;
   prevY = yAxis;
  }
  
  // backOn switch
  if (aBtn == 1 ) backOn = !backOn;
  
  //fill(c);
  //if (prevX > 0 && (abs(xAxis - prevX) > 2 && abs(yAxis - prevY) > 2)) {
    if (prevX > 0 ) {
      stroke(c);
      strokeWeight(20);
      line(prevX, prevY, xAxis, yAxis);
      //ellipse(xAxis, yAxis, 50, 50);
      c = color((red(c) + 1) % 255, green(c), blue(c));
    } else {
      prevX = xAxis;
      prevY = yAxis;
    }
}


public void getUserInput() {
  xAxis = map(cont.getSlider("xAxis").getValue(), -1, 1, 0, width);
  yAxis = map(cont.getSlider("yAxis").getValue(), -1, 1, 0, height);
  aBtn = map(cont.getButton("aBtn").getValue(), 0, 8, 0, 1);
  bBtn = map(cont.getButton("bBtn").getValue(), 0, 8, 0, 1);
  
}
