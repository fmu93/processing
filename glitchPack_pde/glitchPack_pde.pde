import controlP5.*; //<>// //<>//
import java.util.HashMap;
import java.util.Map;
import java.util.Iterator;
import processing.net.*;

ControlP5 cp5;

//PGraphics canvas;
public static LedSystem ledSystem;
public static LetterSystem letterSystem;
public static PatternSystem patternSystem;

boolean makingLEDs = false;
boolean editing = true;
PVector stripStart;
PVector stripEnd;
public static int ledSize = 19;
public static float signalDelay = 800;
public static float fadeDelay = 0.4;
public static float signalSaturation = 0.5;
public static float brightness = 0.5;
public static float saturation = 1;
public static  float incFlow = 0.02;
public static float rateFlow = 0.005;

int selMode = 0;
IntList ledsInside;
float startFrame;

PFont font;

PrintWriter output;
BufferedReader reader;

PImage img;

// socket stuff
Client myClient;
int port = 8080;

/**
 LED strip has 60 led/m, 5 total meters = 300 LEDs
 LEDs in a strip are 1.66 cm away
 
 
 **/

void setup() {
  size(700, 900);
  colorMode(HSB, 1.0);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);

  myClient = new Client(this, "127.0.0.1", port);
  //myClient.write("Trying connection!");

  //canvas = createGraphics(600, 807, JAVA2D);
  font = createFont("arial", 12);
  gui();

  //img = loadImage("res/vest.jpg");
  init();
}


void draw() {
  startFrame = millis();
  background(0.1);

  //imageMode(CENTER);
  //image(img, width/2, height/2, width*0.95, height);
  //showGrid();


  //ledSystem.show();

  //Led ledToSignal = ledSystem.isInside(particles.get(0).pos);

  //ledSystem.signal(ledSystem.isInside(new PVector(mouseX, mouseY))); 

  // showing strip to make leds
  if (editing && stripStart != null && stripEnd != null) {
    stroke(0.5);
    line(stripStart.x, stripStart.y, mouseX, mouseY);    

    PVector stripVector = PVector.sub(stripEnd, stripStart);
    float stripMag = stripVector.mag();
    int ledsInStrip = (floor(stripMag / ledSize) + 1);
    println(ledsInStrip);

    noFill();
    stroke(0.5);
    for (int i = 0; i < ledsInStrip; i++) {
      stripVector.setMag(ledSize*(0.01+ i));
      ellipse(stripStart.x + stripVector.x, stripStart.y + stripVector.y, ledSize, ledSize);
    }
  }

  // pattern test 1
  //patternSystem.updateFlowField();
  //patternSystem.showFlowField();

  //patternSystem.matrix();
  ledSystem.updateFlowField();
  //ledSystem.rainbow();

  // poem test 1
  letterSystem.showQueue();
  //signalDelay = map(cp5.get(Slider.class, "v1").getValue(), 0, 100, 0, 1000);

  // show all color mods
  if (editing) {
    ledSystem.show2();
  } else {
    myClient.write(ledSystem.toSocket());
  }

  // display number of LEDS
  //fill(0);
  //rect(0, 0, 100, 20);
  fill(1);
  text(ledSystem.ledCount(), 10, 10);
  text(frameRate, 50, 10);
  text("selMode: " + selMode, 110, 10);
  float processTime = millis() - startFrame;
  text("millis/f: " + processTime, 250, 10);
  //noLoop();
  //if (mousePressed) {
  //  loop();
  //} else {
  //  noLoop();
  //}
}

void init() {
  ledSystem = new LedSystem();
  letterSystem = new LetterSystem();
  patternSystem = new PatternSystem();
  //loadSelected(new File("/home/pi/Desktop/pipack/glitchPack_pde/stripStoned.txt"));
  //loadSelected(new File("D:/Libraries/Documents/GitHub/processing/glitchPack_pde/stripStoned.txt"));
}

void updateVariable(float val) {
  switch(selMode) {
  case 0:
    if ((brightness >= 0 || val > 0) && (brightness <= 1 || val < 0)) brightness += val/100;
    break;
  case 1:
    if ((signalDelay >= 0 || val > 0) && (signalDelay <= 1500 || val < 0)) signalDelay += val*4;
    break;
      case 2:
    if ((incFlow >= 0 || val > 0) && (incFlow <= 0.1 || val < 0)) incFlow += val/5000;
    break;
      case 3:
    if ((rateFlow >= 0 || val > 0) && (rateFlow <= 0.1 || val < 0)) rateFlow += val/5000;
    break;
  }
}

void mouseClicked(MouseEvent evt) {
  ledsInside = ledSystem.isInside(new PVector(mouseX, mouseY), 0);
  println(ledsInside);
  if (mouseButton == LEFT) {
    if (evt.getCount() == 2) doubleClicked();
    else {
    }
  } else if (mouseButton == RIGHT) {
    if (ledsInside != null) {
      ledSystem.getLed(ledsInside.get(0)).switchSelect();
    }
  }
}

void mouseDragged() {

  ledsInside = ledSystem.isInside(new PVector(mouseX, mouseY), 0);
  // for painting leds
  if (mouseButton == LEFT) {
    if (ledsInside.size() > 0 & !makingLEDs) {
      // Move the LED selected
      ledSystem.getLed(ledsInside.get(0)).move(new PVector(mouseX, mouseY));
    } else if (makingLEDs) {
      if (stripStart == null) {
        stripStart = new PVector(mouseX, mouseY);
      }
      // Add many LEDs
      //ledSystem.addLed(new PVector(mouseX, mouseY));
      stripEnd = new PVector(mouseX, mouseY);
    }
    // for painting letters
  } else if (mouseButton == RIGHT) {
    if (ledsInside.size() > 0) {
      ledSystem.getLed(ledsInside.get(0)).select();
    }
  }
}

void mouseReleased() {
  if (stripStart != null && stripEnd != null) {
    PVector stripVector = PVector.sub(stripEnd, stripStart);
    float stripMag = stripVector.mag();
    int ledsInStrip = (floor(stripMag / ledSize) + 1);

    noFill();
    stroke(0);
    for (int i = 0; i < ledsInStrip; i++) {
      stripVector.setMag(ledSize*(0.01+i));
      ledSystem.addLed(PVector.add(stripStart, stripVector));
    }

    stripStart = null;
    stripEnd = null;
  }
}

void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
    case UP:
      selMode = (selMode+1)%6;
      break;
    case DOWN:
      selMode = (selMode-1)%6;
      break;
    case LEFT:
      updateVariable(-1);
      break;
    case RIGHT:
      updateVariable(1);
      break;
    }
  } else {
    letterSystem.signalLetter((char) key);
  }
}

void doubleClicked() {
  // for painting leds
  if (mouseButton == LEFT) {
    if (ledsInside != null) {
      if (ledsInside.size() > 0) {
        ledSystem.removeLed(ledsInside.get(0));
      }
    } else {
      ledSystem.addLed(new PVector(mouseX, mouseY));
      //if (stripStart == null) {
      //  stripStart = new PVector(mouseX, mouseY);
      //}
    }
    // for selecting leds
  } else if (mouseButton == RIGHT) {
  }
}

public void makePoem() {
  String input = cp5.get(Textfield.class, "input").getText();
  if (input != null) {
    letterSystem.setQueue(input);
  }
}

public void btn1() {
  makingLEDs = !makingLEDs;
  Button btn = ((Button)cp5.getController("btn1"));

  color c;
  if (makingLEDs) c = color(255, 0, 0);
  else c = color(0, 0, 150);
  btn.setColorBackground(c).setLabel(makingLEDs?"Paint":"Move");
}


public void saveConfig() {
  selectInput("Select a file to save:", "saveSelected");
}

void saveSelected(File selection) {
  output = createWriter(selection.getAbsolutePath()); 
  // TODO make center of coordinates center of screen / backpack
  output.println("> Leds positions");
  for (String ledToPrint : ledSystem.stringList()) {
    output.println(ledToPrint);
  }

  // letters
  output.println("> Letter patterns");
  for (Character letterKey : letterSystem.letterMap.keySet()) {
    output.println("Letter:" + letterKey + "," + letterSystem.toSave(letterKey));
  }

  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file  
  println("saved to file!");
}

void loadConfig() {
  selectInput("Select a file to process:", "loadSelected");
}

void loadSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    noLoop();
    reader = createReader(selection.getAbsolutePath());
    println("User selected " + selection.getAbsolutePath());

    String line = "";
    while (line != null) {
      try {
        line = reader.readLine();

        // leds
        String[] m = match(line, "ID:(\\d+),((\\d+\\.\\d+,?)*)");
        if (m != null) {
          int id = int(m[1]);
          String coord[] = m[2].split(","); // id,x,y

          PVector pos_ = new PVector(float(coord[0]), float(coord[1]));
          //println(coord);
          ledSystem.addLed(id, pos_);
        }        
        // letters
        //String[] m2 = match(line, "Letter:(\\[\\s\\S]),\\[((\\d+,?)*)]"); // letter,[int, int, int]
        String[] m2 = match(line, "Letter:(\\s|\\S),\\[((\\d+,?)*)]"); // letter,[int, int, int]
        if (m2 != null) {

          Character letter = m2[1].charAt(0);
          IntList idList = new IntList();
          for (String idString : m2[2].split(",")) {
            idList.append(int(idString));
          }
          letterSystem.addLetter(idList, letter);
        }
        println(line);
      } 
      catch (Exception e) {
        e.printStackTrace();
        line = null;
      }
    }
    delay(500);
    loop();
  }
}

public void saveLetter() {
  String input = cp5.get(Textfield.class, "input").getText();
  if (input.length() == 1) {
    Character letter = input.charAt(0);
    boolean result = letterSystem.addLetter(ledSystem.getSelectedIds(), letter);

    if (result) {
      ledSystem.clearSelection();
      cp5.get(Textfield.class, "input").clear();
      println(input + " saved!");
    }
  }
}

void gui() {
  cp5 = new ControlP5(this);
  cp5.addSlider("v1")
    //  //.setPosition(40, 40)
    //  //.setSize(200, 20)
    .setRange(0, 100)
    .setValue(70);
  //  .setColorCaptionLabel(color(20, 20, 20));
  cp5.addButton("btn1").setLabel("Move");
  cp5.addButton("saveConfig");
  cp5.addButton("loadConfig");
  cp5.addButton("saveLetter");

  cp5.addButton("makePoem");

  cp5.addTextfield("input")
    .setPosition(10, 60)
    .setSize(200, 20)
    .setFont(font)
    .setFocus(true)
    .setLabel("");
}

void showGrid() {
  noFill();
  stroke(0, 50);
  pushMatrix();
  translate(width/2, height/2);
  float res = height / 8;
  for (float i = -height/2; i < height/2; i += res) {
    for (float j = -width/2; j < width/2; j+= res) {
      rect(j, i, res, res);
    }
  }


  popMatrix();
}
