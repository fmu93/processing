import controlP5.*; //<>//
import java.util.HashMap;
import java.util.Map;
import java.util.Iterator;
import processing.net.*;

ControlP5 cp5;

//PGraphics canvas;
public static LedSystem ledSystem;
public static LetterSystem letterSystem;
public static PatternSystem patternSystem;
public static Mode mode;

boolean makingLEDs = false;
static boolean editing = true;
PVector stripStart;
PVector stripEnd;
String inputBuffer = "";
char lastKey = 'a';
int[] selModeLeds = {103, 270, 269, 268, 267, 266, 265, 264};

public static int ledSize = 20;
public static float showSelModeDelay = 3000;
public static float brightness = editing?1:0.2; // this is independent of mode
public static boolean modeLoop = true;
public static float modeInterval = 80000; //2*60*1000; // 2 min in millis
public static float brightSmoothFactor = 0;

// variables in modes

public static boolean lettersOn = false;
public static boolean flowOn = true;
public static float signalDelay = 800;
public static float fadeDelay = 1;
public static float signalSaturation = 0.04;
public static float saturation = 1;
public static float incFlow = 0.07;
public static float rateFlow = 0.06;
public static float incFlow2 = 0.1;
public static float rateFlow2 = 0.08;
public static float shadowFlowFactor = 0.7;

int selMode = 0;
float lastShowSelMode = millis();
public float lastMode = millis();
IntList ledsInside;
public float now;
public int keyPressedCount = 0;

public float beatInterval = 480; // millis between beats, 480 millis = 125 bpm
public float lastBeat;
public float lastBeatSync;
int beats = 0;
float tapSum = 0;
int forgetTime = 3000; // 3 seconds 

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
 
 // LEDs covered by others
 52, 68, 87, 237
 
 // qualitative brightness (in my room with some natural light)
 super bright = 0.8
 very bright = 0.5
 bright = 0.15
 modest = 0.05
 dim = 0.025
 minimum = 0.008
 
 **/

void setup() {
  size(100, 100);
  if (editing) {
    surface.setResizable(true);
    surface.setSize(700, 900);
    font = createFont("arial", 12);
    gui();
    //img = loadImage("res/vest2.jpg");
  }
  frameRate(20);

  colorMode(HSB, 1.0);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);

  myClient = new Client(this, "127.0.0.1", port);
  //myClient.write("Trying connection!");

  init();
}


void draw() {

  now = millis();
  background(0.1);

  // load next mode at intervals TODO check performance adding frameCount % 200 == 0 &&
  if (modeLoop && frameCount % 200 == 0 && millis() - lastMode > modeInterval) {
    mode.nextMode();
  }

  if (flowOn || keyPressed) {    
    patternSystem.updateZ();
    patternSystem.evolveSpread();
  }

  if (flowOn) {
    ledSystem.updateFlowField();
  } else {
    ledSystem.clearColors();
  }

  updateSmooth();

  letterSystem.showQueue();
  //signalDelay = map(cp5.get(Slider.class, "v1").getValue(), 0, 100, 0, 1000);
  if (millis() - lastShowSelMode < showSelModeDelay) {
    showSelMode();
  }

  if (keyPressed && key == CODED) {
    showSelMode();
    lastShowSelMode = millis();
  } else if (keyPressed && key == ' ' && keyPressedCount > 0) {
    ledSystem.rainbow();
  } else {
  }
  // show all color mods
  if (editing) {
    ledSystem.show2();
  } else {
    myClient.write(ledSystem.toSocket());
  }

  if (editing) {
    //image(img, width/2, height/2, width*0.95, height);
    //showGrid();
  }

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

  // display number of LEDS
  fill(1);
  text(ledSystem.ledCount(), 10, 10);
  text(frameRate, 50, 10);
  text("selMode: " + selMode, 110, 10);
  text("interv: " + int(beatInterval), 200, 10);
  float processTime = millis() - now;
  text("millis/f: " + processTime, 300, 10);
}

void init() {
  // TODO load python socket script from here
  /**
   File pythonSocket = new File("/home/pi/Desktop/runLedPack1.sh");
   try {
   Runtime.getRuntime().exec(new String[]{"/bin/sh" ,"-c", pythonSocket.getPath()});
   } catch (Exception e) {
   println(e); 
   }
   //wait(20);
   **/

  ledSystem = new LedSystem();
  letterSystem = new LetterSystem();
  patternSystem = new PatternSystem();
  mode = new Mode(0);
  boolean piLoaded = false;
  piLoaded = loadSelected(new File("/home/pi/Desktop/repos/processing/glitchPack_pde/zug.txt"));
  if (!piLoaded) {
    loadSelected(new File("D:/Libraries/Documents/GitHub/processing/glitchPack_pde/zug.txt"));
  }
  lastBeat = millis();
  lastBeatSync = lastBeat;
}

void updateVariable(float val) {
  switch(selMode) { // TODO same snapshot of all variables in modes class
  case 0:
    if ((brightness >= 0 || val > 0) && (brightness <= 1 || val < 0)) brightness += val/100;
    break;
  case 1:
    if ((signalDelay >= 0 || val > 0) && (signalDelay <= 2000 || val < 0)) signalDelay += val*6;
    break;
  case 2:
    if ((incFlow >= 0 || val > 0) && (incFlow <= 0.16 || val < 0)) incFlow += val/2000;
    break;
  case 3:
    if ((rateFlow >= 0 || val > 0) && (rateFlow <= 0.2 || val < 0)) rateFlow += val/2000;
    break;
  case 4:
    if ((incFlow2 >= 0 || val > 0) && (incFlow2 <= 0.15 || val < 0)) incFlow2 += val/2000;
    break;
  case 5:
    if ((rateFlow2 >= 0 || val > 0) && (rateFlow2 <= 0.2 || val < 0)) rateFlow2 += val/2000;
    break;
  case 6:
    if ((shadowFlowFactor >= 0 || val > 0) && (shadowFlowFactor <= 1.5 || val < 0)) shadowFlowFactor += val/120;
    break;
  }
}

void updateSmooth() {
  if (brightness > 0.05) {
    float avgBri = ledSystem.getAverageBrightness();
    brightSmoothFactor = map(avgBri, 0, brightness, 1, map(brightness, 0, 1, 0.8, 0.5));
  } else {
    brightSmoothFactor = 1;
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
    if (ledsInside.size() > 0) {
      ledSystem.getLed(ledsInside.get(0)).switchSelect();
    }
  }
}

void mouseDragged() {

  ledsInside = ledSystem.isInside(new PVector(mouseX, mouseY), 0);
  // for painting leds
  if (mouseButton == LEFT) {
    if (ledsInside.size() > 0 && !makingLEDs) {
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

void showSelMode() {
  for (int i = 0; i <= selMode; i++) {
    ledSystem.getLed(selModeLeds[i]).setMildSignal();
  }
}

void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
    case UP:
      selMode = (selMode+1)%7;
      showSelMode();
      break;
    case DOWN:
      if (selMode == 0) selMode = 7; 
      selMode = selMode-1;
      showSelMode();
      break;
    case LEFT:
      updateVariable(-1);
      break;
    case RIGHT:
      updateVariable(1);   
      break;
    case RETURN:
    }
  } else {
    // avoid taking the continuous input of a held key
    if (keyPressedCount >= 2 || (keyPressedCount >= 1 && key == lastKey)) return;
    keyPressedCount++;

    if ((key == ENTER || key == RETURN || key == '\n') && lastKey == ' ') {
      letterSystem.setQueue(inputBuffer);
      inputBuffer = "";
    } else if (key == BACKSPACE || key == '\b') {
      if (inputBuffer.length() > 1) {
        inputBuffer = inputBuffer.substring(0, inputBuffer.length()-1);
      }
      if (lastKey == ' ') {
        inputBuffer = "";
      }
    } else if (key == '\t' && lastKey == ' ') {
      lettersOn = !lettersOn;
    } else if (key == '`' && lastKey == ' ') {
      flowOn = !flowOn;
      ledSystem.clearColors();
    } else if (key == '-' && lastKey == ' ') {
      modeLoop = true; // TODO make visible output for modeLoop on/off
    } else if (key == '=' && lastKey == ' ') {
      modeLoop = false;
      //mode.printMode();
    } else if ("1234567890".indexOf(key) != -1 && lastKey == ' ') {
      mode.setMode(parseInt(key)-48);
    } else if (key == ' ' && lastKey == ' ') {
      if (millis()-lastBeat < forgetTime) {
        tapSum += millis() - lastBeat;
        beats++;
        // reset after too many beats
        if (beats >= 16) {
          tapSum = millis() - lastBeat;
          beats = 1;
        } 
        if (beats > 3) {
          beatInterval = beatInterval*0.5 + tapSum/beats*0.5;
          lastBeatSync = millis();
        }
        // reset beats if after forgetTime
      } else {
        tapSum = 0;
        beats = 0;
      }

      lastBeat = millis();
    } else {
      inputBuffer += key;
    }
  }

  lastKey = key;
}

void keyReleased() {
  keyPressedCount = 0;
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

public void makePoem(String input) {
  //String input = cp5.get(Textfield.class, "input").getText();
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

boolean loadSelected(File selection) {
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
        //String line2 = "";
        String[] m2 = match(line, "Letter:(\\s|\\S),\\[((\\d+,?)*)]"); // letter,[int, int, int]
        if (m2 != null) {

          Character letter = m2[1].charAt(0);
          IntList idList = new IntList();
          //line2 += "Letter:" + letter + ",[";
          for (String idString : m2[2].split(",")) {
            int ledId = int(idString);
            //if (ledId >= 41) {
            //  ledId = ledId - 1;
            //}
            idList.append(ledId);
          }
          letterSystem.addLetter(idList, letter);
          //line2 += idList.join(",") + "]";
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
  return (reader != null);
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
  float res = ledSize*5;
  for (float i = -height/2; i < height/2; i += res) {
    for (float j = -width/2; j < width/2; j+= res) {
      rect(j, i, res, res);
    }
  }


  popMatrix();
}
